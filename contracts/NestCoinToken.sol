//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NestCoinToken is ERC20 {

    // uint public tokensPerEth = 1000;
    // struct TransactionInfo {
    //     address txAddress;
    //     string description;
    //     string date;
    // }

    // mapping (address => transactionInfo[]) public userTransactions;

    constructor() ERC20('NestCoinToken', 'NCT') {
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    function userApproveContract(address user, uint numOfTokens) public {
        approve(user, numOfTokens);
    }

    // function rewardUsers(address[] userAddresses, uint amount) public OnlyOwner{
    //     for (uint i = 0; i < userAddresses.length; i++) {
    //         address current = userAddresses[i];
    //         transfer(current, amount * 10**decimals());
    //     }
    // }

    // function payForPerks(uint amount) public {
    //     transfer(address(owner()), amount * 10**decimals());
    // }

    // function withdraw(address to, uint numOfTokens) public {
    //     transfer(address(owner()), numOfTokens * 10**decimals());
    //     uint amountofEth = numOfTokens / tokensPerEth;
    //     payable(msg.sender).transfer(amountofEth);

    // }

    // function sendTransactionInfo(address _txAddress, string memory _description, string memory _date) {
    //     userTransactions[msg.sender].push(TransactionInfo({
    //         txAddress: _txAddress,
    //         description: _description,
    //         date: _date
    //     }));
    // }

    // function getTransactionInfo(address user) public view returns (TransactionInfo[]) {
    //     return userTransactions[msg.sender];
    // }
}