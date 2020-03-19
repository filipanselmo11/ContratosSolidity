pragma solidity >=0.4.21 <0.7.0;

contract Hash {
    bytes32 public hashPart1;
    bytes32 public hashPart2;

    function updateHash(bytes32[2] memory _hash) public returns(bool) {
        hashPart1 = _hash[0];
        hashPart2 = _hash[1];
        return true;
    }

    function getHash() public view returns(bytes memory) {
        bytes memory joined = new bytes(64);
        bytes32 h1 = link.currentHash[0];
        bytes32 h2 = link.currentHash[1];
        assembly {
            mstore(add(joined, 32), h1)
            mstore(add(joined, 64), h2)
        }
        return joined;
    }
}