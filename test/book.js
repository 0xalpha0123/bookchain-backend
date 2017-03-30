var Book = artifacts.require("Book");
pry = require('pryjs');
contract('Book', function(accounts) {

  it('should have a name', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance.name.call();
    }).then(function(name) {
      var parsedString = web3.toAscii(name);
      assert.include(parsedString, 'Moby Dick');
    });
  });

  it('should be available by default', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance.isAvailable.call();
    }).then(function(isAvailable) {
      assert.isTrue(isAvailable,'This should be true.');
    });
  });

  it('should be unavailable after being checked out', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance;
    }).then(function(instance) {
      instance.checkout();
      assert.isNotTrue(instance.isAvailable);
    });
  });

  it('should be available after being returned', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance;
    }).then(function(instance) {
      // eval(pry.it)
      instance.checkout();
      instance.isAvailable().then(function(i) {assert.isNotTrue(i);});
      instance.returnBook();
      instance.isAvailable().then(function(i) {assert.isTrue(i);});
    });
  });

  it('validates checkout function', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance;
    }).then(function(instance) {
      assert.isFunction(instance.checkout);
    });
  });

  it('validates returnBook function', function() {
    var book = Book.new("Moby Dick", "Van Dyke");
    return book.then(function(instance) {
      return instance;
    }).then(function(instance) {
      assert.isFunction(instance.returnBook);
    });
  });

});
