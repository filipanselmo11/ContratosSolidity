pragma solidity >=0.4.21 <0.7.0;

contract GasTest {
    string public hashString;
    bytes32 public hash;
    bytes32[2] public linkHash;
    bytes32 public linkPart1;
    bytes32 public linkPart2;
    LinkObject private link;

    struct LinkObject {
        bytes32[2] currentHash;
    }

    function updateLink(bytes32[2] memory _newHash) public returns (bool) {
        link.currentHash = _newHash;
        return true;
    }

    function updateLinkHash(bytes32[2] memory _newHash) public returns (bool) {
        
    }
}