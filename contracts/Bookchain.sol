pragma solidity ^0.4.4;

contract Bookchain {

    // bookshelf array = all book contract addresses 
    // available books array = dynamic array of available book structs
    // available book struct = { title, author, owner address?, image_url, book contract address}

    function Bookchain() {
        // set the contract owner
        // initialize money
    }

    function createBook() {
        // when you create a book 
        // and it returns true
        // store address in bookshelf array
    }

    // returns structs/tuples with info for all available books 
    // title, author, image_url, contract address
    // 
    function availableBooks() returns () {
        // for each address in bookshelf
        // check book status
        // if book is available
        // push struct of {title, author,  } 
        // to available books array
    }
}
