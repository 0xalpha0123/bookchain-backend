pragma solidity ^0.4.8;
import "./Book.sol";
import "./BookCoin.sol";

contract Bookchain {

    // bookshelf array = all book contract addresses 
    Volume[] public bookshelf;

    struct Volume {
        bytes32 isbn;
        address bookContractAddress;
        bool status;
    }
    // available books array = dynamic array of available book structs
    // available book struct = { title, author, owner address?, image_url, book contract address}

    // address (public?) bookcoinAddress; or is this an inheritance

    // Bookchain State
    address public owner;

    // Modifiers
    modifier onlyOwner { if(msg.sender != owner) throw; _; }

    // Events
    event bookAddedToShelf(address bookContract, bytes32 isbn, address owner);
    event bookMadeAvailable(bytes32 isbn);
    event bookMadeUnavailable(bytes32 isbn);

    event refreshBookshelf();

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

    function createBook(bytes32 _isbn) returns(bool) {
        // when you create a book 
        address newBook = new Book(_isbn, owner);
        // store address in bookshelf array
        bookshelf.push( Volume({
            isbn: _isbn,
            bookContractAddress: address(newBook),
            status: true,
        }));
        // trigger event for react frontend to pick up 
        bookAddedToShelf(address(newBook), _isbn, msg.sender);
        return true;
        // and it returns true
        /*
            msg.sender gets 3BKC
        */
    }

    function getBookshelfCount() public constant returns(uint) {
        return bookshelf.length;
    }

    function getBookshelf() public constant returns(bytes32[], address[], bool[]) {
        
        uint length = bookshelf.length;
        
        bytes32[] memory isbns = new bytes32[](length);
        address[] memory contractAddresses = new address[](length);
        bool[] memory currentStatus = new bool[](length);
        
        for (uint i = 0; i < length; i++) {
            Volume memory currentVolume;
            currentVolume = bookshelf[i];
            
            isbns[i] = currentVolume.isbn;
            contractAddresses[i] = currentVolume.bookContractAddress;
            currentStatus[i] = currentVolume.status;
        }
        
        
        return (isbns, contractAddresses, currentStatus);
    }


    function borrowBook(address _bookContract) {
        // if book is available

        // create a borrow agreement b/w owner and borrower
        // collect deposits
        /*
            upon completion both parties get 1BKC
        */
    }

    // returns structs/tuples with info for all available books 
    // title, author, image_url, contract address
    // 
    // maybe: event in book contract to update available books array
    //        when status of book changes

    function availableBooks() {
        // for each address in bookshelf
        // if book.status is available
        // push struct of {title, author, owner address?, image_url, book contract address} 
        // to available books array
    }

    // contract self-destruct
    function kill() onlyOwner {
        selfdestruct(owner);
    }
}
