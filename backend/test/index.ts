import { expect } from "chai";
import { ethers } from "hardhat";

describe("Mint", function () {
  it("Should mint an NFT", async function () {
    const accounts = await ethers.getSigners();
    const user = accounts[1];

    const FreeMints = await ethers.getContractFactory("FreeMints");
    const freeMints = await FreeMints.deploy();
    await freeMints.deployed();

    expect(await freeMints.uriMap(user.address, "0")).to.be.equal("");

    await freeMints.mint(user.address, "something.xyz");

    expect(await freeMints.uriMap(user.address, "0")).to.be.equal(
      "something.xyz"
    );
  });
});
