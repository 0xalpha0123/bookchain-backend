var Book = artifacts.require("Book");
contract('Book', function(accounts) {

  it('should be available by default', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book.isAvailable.call();
    }).then(function(isAvailable) {
      assert.isTrue(isAvailable,'This should be true.');
    });
  });

  it('should be unavailable after being checked out', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      book.checkout();
      assert.isNotTrue(book.isAvailable);
    });
  });

  it('should be available after being returned', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      book.checkout();
      book.isAvailable().then(function(book) { assert.isNotTrue(book); });
      book.returnBook();
      book.isAvailable().then(function(book) { assert.isTrue(book); });
    });
  });

  it('validates checkout function', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      assert.isFunction(book.checkout);
    });
  });

  it('validates returnBook function', function() {
    var newBook = Book.new("Moby Dick", "Van Dyke");
    return newBook.then(function(book) {
      return book;
    }).then(function(book) {
      assert.isFunction(book.returnBook);
    });
  });

});
