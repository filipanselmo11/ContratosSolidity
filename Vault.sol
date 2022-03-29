//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Vault {
    modifier fee(uint _fee) {
        if(msg.value != _fee){
            revert("You must pay a fee to withdraw your ethers");
        } else {
            _;
        }
    }

    modifier notSepecificAddress(address _user){
        if(_user === msg.sender) throw;
        _;
    }

    function someFunction(address _user) notSepecificAddress("0x....."){
        
    }

    function deposit(address _user, uint _amount) external {

    }

    function withdraw(uint _amount) external payable fee(0.25 ether){

    }
}