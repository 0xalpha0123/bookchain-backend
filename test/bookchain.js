var Bookchain = artifacts.require("./Bookchain.sol");
pry = require('pryjs');

contract('Bookchain', function(accounts) {

  it('should have an owner', function() {
    var owner = accounts[0];
    var newBookchain = Bookchain.new({from: owner});
    return newBookchain.then(function(bookchain) {
      return bookchain.owner.call();
    }).then(function(owner) {
      assert.include(owner, accounts[0]);
    });
  });

  it('can add a book', function() {
    var owner = accounts[0];
    var newBookchain = Bookchain.new({from: owner});
    var newBookIsbn = 123456789;
    return newBookchain.then(function(bookchain) {
      bookchain.createBook(newBookIsbn, {from: owner});
      // bookchain.getBookshelfCount().then(function(bookshelfCount) {
      //   assert.equal(bookshelfCount, 1)
      // });
      bookchain.getBookshelf().then(function(volume) {
        assert.equal(volume, '100')
      });
    });
  });
});