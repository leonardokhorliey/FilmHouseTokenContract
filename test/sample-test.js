
const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");
const { utils } = require("ethers");

use(solidity);

describe("NestCoinToken", function () {
  it("Should mint 1000000 tokens to msg.sender", async () => {
    
    const NestCoinToken = await hre.ethers.getContractFactory("NestCoinToken");
    const nestcoin = await NestCoinToken.deploy();

    await nestcoin.deployed();
    const owner = nestcoin.deployTransaction.from;

    //await nestcoin.transfer( nestcoin.address, utils.parseEther("1000000") );

    const valueMinted = await nestcoin.balanceOf(owner);
    expect(valueMinted).to.equal(ethers.utils.parseEther("1000000"));
  });
});

describe("NestCoinToken", function () {
  it("Should transfer the number of tokens to the holdingAddress", async () => {
    const NestCoinToken = await hre.ethers.getContractFactory("NestCoinToken");
    const nestcoin = await NestCoinToken.deploy();

    await nestcoin.deployed();

    const NestTract = await hre.ethers.getContractFactory("NestTract");
    const nesttract = await NestTract.deploy(nestcoin.address);

    await nesttract.deployed();

    await nestcoin.payForPerks(2, nesttract.address);

    expect(await nestcoin.balanceOf(nesttract.address)).to.equal(ethers.utils.parseEther("2"));
  });

  
});

describe("NestTract", function () {
  it("Should reward list of users send in to reward", async () => {
    const NestCoinToken = await hre.ethers.getContractFactory("NestCoinToken");
    const nestcoin = await NestCoinToken.deploy();

    await nestcoin.deployed();

    const NestTract = await hre.ethers.getContractFactory("NestTract");
    const nesttract = await NestTract.deploy(nestcoin.address);

    await nesttract.deployed();

    await nestcoin.transfer( nesttract.address, utils.parseEther("1000000") );

    const userstoReward = ["0x1d80b14fc72d953eDfD87bF4d6Acd08547E3f1F6", "0x120920E61C00989B7F7554DC79fBf2c47f360aEA"]

    await nesttract.rewardUsers(userstoReward, 5);

    const firstBal = await nestcoin.balanceOf(userstoReward[0]);
    //firstBal = firstBal.toString();
    const secondBal = await nestcoin.balanceOf(userstoReward[1]);
    //secondBal = secondBal.toString();
    const addressBal = await nestcoin.balanceOf(nesttract.address);
    //addressBal = addressBal.toString();

    expect(firstBal).to.equal(utils.parseEther("5"));
    expect(secondBal).to.equal(utils.parseEther("5"));
    expect(addressBal).to.equal(utils.parseEther("999990"));

  });

  
})