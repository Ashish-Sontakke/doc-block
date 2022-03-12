const Authority = artifacts.require("Authority");
const BlockPrint = artifacts.require("BlockPrint");
const Owner = artifacts.require("Owner");

module.exports = function(deployer) {
  deployer.deploy(Authority);
  deployer.deploy(BlockPrint);
  deployer.deploy(Owner);
};
