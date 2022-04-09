//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./NestCoinToken.sol";

contract NestTract is Ownable {

    NestCoinToken public nestcoin;

    mapping (address => bool) public admin;

    constructor(address _nestcoin) {
        nestcoin = NestCoinToken(_nestcoin);
        admin[msg.sender] = true;
    }

    modifier isAnAdmin() {
        require(admin[msg.sender], "You are not an Admin on the contract");
        _;
    }

    function addAdmin(address add) public isAnAdmin {
        admin[add] = true;
    }

    function supplyEth(uint amount) public payable onlyOwner {
        payable(nestcoin).send(amountofEth);
    }

    function removeAdmin(address add) public onlyOwner {
        admin[add] = false;
    }

    function isContractOwner(address user) public view returns (bool) {
        return user == owner();
    }

    function isAdmin(address user) public view returns (bool) {
        return admin[user];
    }

    function rewardUsers(address[] calldata userAddresses, uint amount) public isAnAdmin {
        uint dec = nestcoin.decimals();
        for (uint i = 0; i < userAddresses.length; i++) {
            address current = userAddresses[i];
            nestcoin.transfer(current, amount * 10**dec);
        }
    }

    function rewardUser(address userAddress, uint amount) public isAnAdmin {
        uint dec = nestcoin.decimals();
        nestcoin.transfer(userAddress, amount * 10**dec);
        
    }

    function getTokenBalance() public view returns (uint) {
        return nestcoin.balanceOf(msg.sender);
    }
}