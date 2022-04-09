//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NestCoinToken is ERC20, Ownable {

    uint public tokensPerEth = 1000;
    // struct TransactionInfo {
    //     address txAddress;
    //     string description;
    //     string date;
    // }

    // mapping (address => transactionInfo[]) public userTransactions;

    mapping (address => bool) public admin;

    constructor() ERC20('NestCoinToken', 'NCT') {
        _mint(msg.sender, 1000000 * 10**decimals());
        admin[msg.sender] = true;
    }

    receive() external payable {

    }
 

    function payForPerks(uint amount, address holdingAddress) public {
        transfer(holdingAddress, amount * 10**decimals());
    }

    function withdraw(uint numOfTokens, address holdingAddress) public {
        transfer(holdingAddress, numOfTokens * 10**decimals());
        uint amountofEth = numOfTokens / tokensPerEth;
        payable(msg.sender).transfer(amountofEth);

    }

    function getTokenBalance() public view returns (uint) {
        return balanceOf(msg.sender);
    }

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