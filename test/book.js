var Book = artifacts.require("./Book.sol");

contract('Book', function(accounts) {
  var varName = "name"
  it('should be created with a name', function() {
    return Book.deployed().then(function(bookInstance) {
      return bookInstance.create().call(varName);
    }).then(function(name) {
      assert.equal(name, varName);
    });
  });
});
