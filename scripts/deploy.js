const hre = require("hardhat");
const fs = require("fs");
const { utils } = require("ethers");

async function main() {
  
  const NestCoinToken = await hre.ethers.getContractFactory("NestCoinToken");
  const nestcoin = await NestCoinToken.deploy();

  await nestcoin.deployed();

  console.log("NestCoinToken deployed to:", nestcoin.address);

  const NestTract = await hre.ethers.getContractFactory("NestTract");
  const nesttract = await NestTract.deploy(nestcoin.address);

  await nesttract.deployed();

  console.log("NestTract deployed to:", nesttract.address);

  await nestcoin.transfer( nesttract.address, utils.parseEther("1000000") );

  fs.writeFileSync(`contractAddress.txt`, `${nestcoin.address} ${nesttract.address}`);
  //fs.writeFileSync(`contract.json`, nesttract);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });