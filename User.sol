pragma solidity >=0.4.21 <0.7.0;

contract Users {
    struct User {
        string name;
        bytes32 status;
        address walletAddress;
        uint createdAt;
        uint updateAt;
    }
    
    mapping(address => uint) public usersIds;
    
    User[] public users;
    
    event newUser(uint id);
    event userUpdateEvent(uint id);
    
    modifier checkSenderIsRegistered {
        require(isRegistred());
        _;
    }
    
    constructor() public {
        addUser(address(0x0), "", "");
        
        addUser(address(0x333333333333), "Leo Brown", "Avaiable");
        addUser(address(0x111111111111), "John Doe", "Very happy");
        addUser(address(0x222222222222), "Mary Smith", "Not in the mood today");
        
    }
    
    function registerUser(string memory _userName, bytes32 _status) public returns(uint){
        return addUser(msg.sender, _userName, _status);
    }
    
    function addUser(address _wAddr, string memory _userName, bytes32 _status) private returns(uint) {
        uint userId = usersIds[_wAddr];
        require(userId == 0);
        
        usersIds[_wAddr] = users.length;
        uint newUserId = users.length++;
        
        users[newUserId] = User({
            name: _userName,
            status: _status,
            walletAddress: _wAddr,
            createdAt: now,
            updateAt: now
        });
        
        emit newUser(newUserId);
        
        return newUserId;
    }
    
    function updateUser(string memory _newUserName, bytes32 _newStatus) checkSenderIsRegistered public returns(uint){
        uint userId = usersIds[msg.sender];
        
        User storage user = users[userId];
        
        user.name = _newUserName;
        user.status = _newStatus;
        user.updateAt = now;
        
        emit userUpdateEvent(userId);
        
        return userId;
        
    }
    
    function getUserById(uint _id) public view returns(uint, string memory, bytes32, address, uint, uint) {
        require((_id > 0) || (_id <= users.length));
        User memory i = users[_id];
        return(_id, i.name, i.status, i.walletAddress, i.createdAt, i.updateAt);
    }
    
    function getOwnProfile() checkSenderIsRegistered public view returns(uint, string memory, bytes32, address, uint, uint) {
        uint id = usersIds[msg.sender];
        return getUserById(id);
    }
    
    function isRegistred() public view returns(bool) {
        return(usersIds[msg.sender] > 0);
    }
    
    function totalUsers() public view returns(uint) {
        return users.length - 1;
    }
    
    
}