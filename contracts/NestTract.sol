//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./NestCoinToken.sol";

contract NestTract is Ownable {

    NestCoinToken public nestcoin;

    uint public tokensPerEth = 1000;
    struct TransactionInfo {
        address txAddress;
        string description;
        string date;
    }

    //uint dec = nestcoin.decimals();

    mapping (address => TransactionInfo[]) public userTransactions;

    mapping (address => bool) public admin;

    constructor(address _nestcoin) {
        nestcoin = NestCoinToken(_nestcoin);
        admin[msg.sender] = true;
    }

    modifier isAdmin() {
        require(admin[msg.sender], "You are not an Admin on the contract");
        _;
    }

    function addAdmin(address add) public isAdmin {
        admin[add] = true;
    }

    function removeAdmin(address add) public onlyOwner {
        admin[add] = false;
    }

    function rewardUsers(address[] calldata userAddresses, uint amount) public isAdmin {
        uint dec = nestcoin.decimals();
        for (uint i = 0; i < userAddresses.length; i++) {
            address current = userAddresses[i];
            nestcoin.transfer(current, amount * 10**dec);
        }
    }

    function rewardUser(address userAddress, uint amount) public isAdmin {
        uint dec = nestcoin.decimals();
        nestcoin.transfer(userAddress, amount * 10**dec);
        
    }

    function payForPerks(uint amount) public {
        uint dec = nestcoin.decimals();
        nestcoin.userApproveContract(msg.sender, amount * 10**dec);
        nestcoin.transferFrom(msg.sender, address(this), amount * 10**dec);
    }

    function withdraw(uint numOfTokens) public {
        uint dec = nestcoin.decimals();
        nestcoin.userApproveContract(msg.sender, numOfTokens * 10**dec);
        nestcoin.transferFrom(msg.sender, address(this), numOfTokens * 10**dec);
        uint amountofEth = numOfTokens / tokensPerEth;
        payable(msg.sender).transfer(amountofEth);

    }

    function setTransactionInfo(address _txAddress, string memory _description, string memory _date) public {
        userTransactions[msg.sender].push(TransactionInfo({
            txAddress: _txAddress,
            description: _description,
            date: _date
        }));
    }

    function getTransactionInfo() public view returns (TransactionInfo[] memory) {
        TransactionInfo[] memory res = userTransactions[msg.sender];
        return res;
    }

    function getTokenBalance() public view returns (uint) {
        return nestcoin.balanceOf(msg.sender);
    }
}