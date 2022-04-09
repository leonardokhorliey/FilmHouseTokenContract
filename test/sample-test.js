
const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);


describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

describe("NestCoinToken", function () {
  it("Should mint 1000000 tokens to msg.sender", async () => {
    const NestCoinToken = await hre.ethers.getContractFactory("NestCoinToken");
    const nestcoin = await NestCoinToken.deploy();

    await nestcoin.deployed();
    expect(await nestcoin.balanceOf("0x940F80Cd7cA57a2565DAF3D79980f90A32233b80")).to.equal(1000000000000000000000000);
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

    expect(await nestcoin.balanceOf(userstoReward[0])).to.equal(ethers.utils.parseEther("5"));
    expect(await nestcoin.balanceOf(userstoReward[1])).to.equal(ethers.utils.parseEther("5"));
    expect(await nestcoin.balanceOf(nesttract.address)).to.equal(ethers.utils.parseEther("999990"));

  });

  
})