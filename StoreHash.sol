pragma solidity >=0.4.21 <0.7.0;

contract SimpleStorage {
    uint storeData;
    
    function set(uint x) public {
        storeData = x;
    }
    
    function get() public view returns(uint) {
        return storeData;
    }
}