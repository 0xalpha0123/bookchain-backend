var Book = artifacts.require("./Book.sol");

module.exports = function(deployer) {
  deployer.deploy(Book);
};
