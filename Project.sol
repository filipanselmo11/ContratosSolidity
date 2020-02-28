pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
contract Project {
    using SafeMath for uint256;
    
    enum State {
        Fundraising,
        Expired,
        Successful
    }
    
    address payable public creator;
    uint public amountGoal;
    uint public completeAt;
    uint256 public currentBalance;
    uint public raiseBy;
    string public title;
    string public description;
    State public state  = State.Fundraising;
    mapping(address => uint) public contributions;
    
    event FundingReceived(address contributor, uint amount, uint currentTotal);
    
    event CreatorPaid(address recipient);
    
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    
    modifier isCreator() {
        require(msg.sender == creator);
        _;
    }
    
    constructor
    (
        address payable projectStarter,
        string memory projectTitle,
        string memory projectDesc,
        uint fundRaisingDeadline,
        uint goalAmount
    ) public {
        
        creator = projectStarter;
        title = projectTitle;
        description = projectDesc;
        amountGoal = goalAmount;
        raiseBy = fundRaisingDeadline;
        currentBalance = 0;
    }
    
    function contribute() external inState(State.Fundraising) payable {
        require(msg.sender != creator);
        contributions[msg.sender] = contributions[msg.sender].add(msg.value);
        currentBalance = currentBalance.add(msg.value);
        emit FundingReceived(msg.sender, msg.value, currentBalance);
        checkIfFundingCompleteOrExpired();
    }
    
    function checkIfFundingCompleteOrExpired() public {
        if(currentBalance >= amountGoal) {
            state = State.Successful;
            payOut();
        } else if(now > raiseBy) {
            state = State.Expired;
        }
        
        completeAt = now;
    }
    
    function payOut() internal inState(State.Successful) returns(bool) {
        uint256 totalRaised = currentBalance;
        currentBalance = 0;
        if(creator.send(totalRaised)) {
            emit CreatorPaid(creator);
            return true;
        } else {
            currentBalance = totalRaised;
            state = State.Successful;
        }
        
        return false;
    }
    
    function getRefund() public inState(State.Expired) returns(bool) {
        require(contributions[msg.sender] > 0);
        
        uint amountToRefund = contributions[msg.sender];
        contributions[msg.sender] = 0;
        
        if(!msg.sender.send(amountToRefund)) {
            contributions[msg.sender] = amountToRefund;
            return false;
        } else {
            currentBalance = currentBalance.sub(amountToRefund);
        }
    }
}