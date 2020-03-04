pragma solidity >=0.4.21 <0.7.0;

contract CrudUser {
    struct UserStruct {
        bytes32 userEmail;
        uint userAge;
        uint index;
    }

    mapping(address => UserStruct) private userStructs;
    address[] private userIndex;

    event LogNewUser(address indexed userAddress, uint index, bytes32 userEmail, uint userAge);
    event LogUpdateUser(address indexed userAddress, uint index, bytes32 userEmail, uint userAge);

    function isUser(address userAddress) public view returns(bool isIndeed) {
        if(userIndex.length == 0 ) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }

    function insertUser(address userAddress, bytes32 userEmail, uint userAge) public returns(uint index) {
        if(isUser(userAddress)) revert("Erro");
        userStructs[userAddress].userEmail = userEmail;
        userStructs[userAddress].userAge = userAge;
        userStructs[userAddress].index = userIndex.push(userAddress)-1;
        emit LogNewUser(userAddress, userStructs[userAddress].index, userEmail, userAge);
        return userIndex.length-1;
    }

    function getUser(address userAddress) public view returns(bytes32 userEmail, uint userAge, uint index) {
        if(!isUser(userAddress)) revert("Erro");
        return(userStructs[userAddress].userEmail, userStructs[userAddress].userAge, userStructs[userAddress].index);
    }

    function updateUserEmaiL(address userAddress, bytes32 userEmail) public returns(bool success) {
        if(!isUser(userAddress)) revert("Erro");
        userStructs[userAddress].userEmail = userEmail;
        emit LogUpdateUser(userAddress, userStructs[userAddress].index, userEmail, userStructs[userAddress].userAge);
        return true;
    }

    function updateUserAge(address userAddress, uint userAge) public returns(bool success) {
        if(!isUser(userAddress)) revert("Erro");
        userStructs[userAddress].userAge = userAge;
        emit LogUpdateUser(userAddress, userStructs[userAddress].index, userStructs[userAddress].userEmail, userAge);
        return true;
    }

    function getUserCount() public view returns(uint count) {
        return userIndex.length;
    }

    function getUSerAtIndex(uint index) public view returns(address userAddress) {
        return userIndex[index];
    }



}