pragma solidity 0.8.10;

contract SimpleWhiteList{
    address public owner;
    mapping(address => bool) public whitelist;

    event LogProtected(address sender);

    modifier onlyOnwer{
        require(msg.sender == owner, "Você não é o proprietário");
        _;
    }

    modifier onlyWhitelist {
        require(whitelist[msg.sender], 
        "Você não está na lista branca");
    }

    function setPermission(address user, bool isAllowed) public onlyOwner {
        whitelist[user] = isAllowed;
    }

    function protected() public onlyWhitelist {
        emit LogProtected(msg.sender);
    }
}

