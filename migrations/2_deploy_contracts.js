var Book = artifacts.require("./Book.sol");
var BookCoin = artifacts.require("./BookCoin.sol");
var Bookchain = artifacts.require("./Bookchain.sol");

module.exports = function(deployer) {
  deployer.deploy(Book);
  deployer.deploy(BookCoin);
  deployer.deploy(Bookchain);
};
