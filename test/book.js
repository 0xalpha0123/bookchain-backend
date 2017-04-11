var Book = artifacts.require("Book");
contract('Book', function(accounts) {

  xit('should have a title', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book.title.call();
    }).then(function(title) {
      var parsedString = web3.toAscii(title);
      assert.include(parsedString, 'Moby Dick');
    });
  });

  xit('should be available by default', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book.isAvailable.call();
    }).then(function(isAvailable) {
      assert.isTrue(isAvailable,'This should be true.');
    });
  });

  xit('should be unavailable after being checked out', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      book.checkout();
      assert.isNotTrue(book.isAvailable);
    });
  });

  xit('should be available after being returned', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      // eval(pry.it)
      book.checkout();
      book.isAvailable().then(function(book) {
        assert.isNotTrue(book);
      });
      book.returnBook();
      book.isAvailable().then(function(book) {
        assert.isTrue(book);
      });
    });
  });

  xit('validates checkout function', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      assert.isFunction(book.checkout);
    });
  });

  xit('validates returnBook function', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      assert.isFunction(book.returnBook);
    });
  });

});
