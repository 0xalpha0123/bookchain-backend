var Bookchain = artifacts.require("./Bookchain.sol");

module.exports = function(deployer) {
  deployer.deploy(Bookchain);
};
