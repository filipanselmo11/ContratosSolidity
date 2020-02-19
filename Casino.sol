pragma solidity >=0.4.21 <0.7.0;

import "./Mortal.sol";

contract Casino is Mortal {
    uint minBet;
    uint houseEdge;
    
    event Won(bool _status, uint _amount);
    
    function Casino(uint _minBet, uint _houseEdge) payable public {
        require(_minBet > 0);
        require(_houseEdge <= 1000);
        minBet = _minBet;
        houseEdge = _houseEdge;
    }
    
    function() public {
        revert();
    }
    
    function bet(uint _number) payable public {
        require(_number > 0 && _number <= 10);
        require(msg.value >= minBet);
        uint winningNumber = block.number % 10 + 1;
        if(_number == winningNumber) {
            uint amountWon = msg.value * (100 - houseEdge) / 10;
            if(!msg.sender.send(amountWon)) revert();
            emit Won(true, amountWon);
        } else {
            emit Won(false, 0);
        }
        
    }
    
    function checkContractBalance() Owned public view returns(uint){
        address _contract = this;
        return _contract.balance;
    }
}