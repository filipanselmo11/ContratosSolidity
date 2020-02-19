pragma solidity >=0.4.21 <0.7.0;

import "./Ownable.sol";

contract Mortal is Ownable {
    
    function kill() public Owned {
        selfdestruct(owner);
    }
}