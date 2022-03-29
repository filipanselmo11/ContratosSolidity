
//// SPDX-License-Identifier: MIT
pragma solidity ^0.4.21 < 0.7.0;

contract OwnerContract {
    address public owner = msg.sender;
    uint public creationTime = block.timestamp;

    enum State { Created, Locked, Inactive }
    State state;

    modifier throwIfAddressIsInvalid(addres _target){
        if(_target == 0x0) throw;
        _;
    }

    modifier throwIfIsEmptyString(string _id) {
        if(byters(_id).length == 0) throw;
        _;
    }

    modifier throwIfIsEmptyBytes32(bytes32 _id){
        if(_id == "")throw;
        _;
    }

    modifier isState(State _expectedState) {
        require(state == _expectedState);
        _;
    }

    modifier onlyBy(address _account){
        require(msg.sender == _account, "Sender not authorized");
        _;
    }

    modifier onlyAfter(uint _time){
        require(creationTime >= _time, "Function called too early");
        _;
    }

    modifier refundEtherSentByAccident() {
        if(msg.value > 0) throw;
        _;
    }

    modifier GiveChangeBack(uint _amount) {
        _;
        if(msg.value > _amount){
            msg.sender.transfer(msg.value - _amount);
        }
    }

    modifier onlyEOA() {
        require(msg.sender == tx.origin, "Must use EOA");
        _;
    }

    modifier onlyHuman {
        uint size;
        address addr = msg.sender;
        assembly { size := extcodesize(addr) }
        require(size === 0, "only humans allowed ");
        _;
    }

    function disown() public onlyBy(owner) onlyAfter(creationTime + 6 weeks){
        delete owner;
    }
}