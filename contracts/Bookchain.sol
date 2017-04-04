pragma solidity ^0.4.10;
import "./Book.sol";
import "./BookCoin.sol";

contract Bookchain {

    // bookshelf array = all book contract addresses 
    // available books array = dynamic array of available book structs
    // available book struct = { title, author, owner address?, image_url, book contract address}

    // address (public?) bookcoinAddress; or is this an inheritance

    // Bookchain State
    address public owner;

    // Modifiers
    modifier onlyOwner() { if(msg.sender != owner) throw; _; }

    function Bookchain() {
        // set the contract owner
        owner = msg.sender;
        /*
            create new BookCoin contract
            set owner to minter
            give minter 1000BKC
            set currency contract address 
        */
    }

    function createBook() {
        // when you create a book 
        // and it returns true
        // store address in bookshelf array
        /*
            msg.sender gets 3BKC
        */
    }

    function borrowBook(address _bookContract) {
        // if book is available
        // create a borrow agreement b/w owner and borrower
        /*
            upon completion both parties get 1BKC
        */
    }

    // returns structs/tuples with info for all available books 
    // title, author, image_url, contract address
    // 
    // maybe: event in book contract to update available books array
    //        when status of book changes

    function availableBooks() returns () {
        // for each address in bookshelf
        // if book.status is available
        // push struct of {title, author, owner address?, image_url, book contract address} 
        // to available books array
    }

    // contract self-destruct
    function kill() onlyOwner() {
        selfdestruct(owner);
    }
}
