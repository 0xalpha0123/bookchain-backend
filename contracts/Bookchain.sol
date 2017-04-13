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

    // mapping of isbn to book contract address for created books
    mapping(bytes32 => address) public checkBook;
    // who currently is borrowing a bookContract
    mapping(address => address) public checkoutLedger;

    // Bookchain State
    address public owner;
    address public bookcoinContract;

    // Modifiers
    modifier onlyOwner { if(msg.sender != owner) throw; _; }

    // Events
    event bookAddedToShelf(address bookContract, bytes32 isbn);
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
        bookcoinContract = new BookCoin(1000, msg.sender);
    }
    
    function bookcoinTotalSupply() returns (uint256) {
        BookCoin bkc = BookCoin(bookcoinContract);
        return bkc.totalSupply();
    }
    
    function getBalance(address _account) returns (uint256) {
        BookCoin bkc = BookCoin(bookcoinContract);
        return bkc.balanceOf(_account);
    }
    
    function payment(address _from, address _to, uint256 _amount) returns (bool) {
        BookCoin bkc = BookCoin(bookcoinContract);
        if (bkc.transferFrom(_from, _to, _amount) ) {
            return true;
        }
        return false;
    }
    
    function registerUser() returns (bool) {
        BookCoin bkc = BookCoin(bookcoinContract);
        if (bkc.balanceOf(msg.sender) == 0) {
            bkc.transfer(msg.sender, 10);
            return true;
        } else {
            return false;
        }
    }

    function checkoutBook(bytes32 _isbn) returns(bool) {
        if (getBalance(msg.sender) < 1) {throw;}
        // does book exist?
        if (checkBook[_isbn] == 0) {throw;}
        // does user already have a book checked out
        if (checkoutLedger[msg.sender] != 0) {throw;}
        // set book mapping status to unavailable
        uint length = bookshelf.length;
        for (uint i = 0; i < length; i++) {
            Volume memory currentVolume;
            currentVolume = bookshelf[i];
            // set book contract status to unavailable
            if (currentVolume.isbn == _isbn) {
                BookCoin bkc = BookCoin(bookcoinContract);
                if (bkc.transferFrom(msg.sender, this, 1)) {
                    bookshelf[i].status = false;
                    // set current borrower of book
                    checkoutLedger[msg.sender] = currentVolume.bookContractAddress;
                    return true;                    
                }
            }
        }
    }

    function returnBook(bytes32 _isbn) returns(bool) {
        if (checkoutLedger[msg.sender] == 0) {throw;}

        uint length = bookshelf.length;
        for (uint i = 0; i < length; i++) {
            Volume memory currentVolume;
            currentVolume = bookshelf[i];
            // set book contract status to unavailable
            if (currentVolume.isbn == _isbn) {
                if (checkoutLedger[msg.sender] != currentVolume.bookContractAddress) {throw;}
                BookCoin bkc = BookCoin(bookcoinContract);
                bkc.mint(1);
                bkc.transferFrom(this, msg.sender, 2);
                bookshelf[i].status = true;
                // set current borrower of book
                checkoutLedger[msg.sender] = 0;
                return true;
            }
        }

    }

    function createBook(bytes32 _isbn) returns(bool) {
        // check if book exists
        if (checkBook[_isbn] == 0) {
            address newBook = new Book(_isbn, msg.sender, owner);
            // store address in bookshelf array
            bookshelf.push( Volume({
                isbn: _isbn,
                bookContractAddress: address(newBook),
                status: true,
            }));
            checkBook[_isbn] = newBook;
            // trigger event for react frontend to pick up
            bookAddedToShelf(address(newBook), _isbn);
            return true;
            /*
                msg.sender gets 3BKC
            */
        } else {
            return false;
        }
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

    // contract self-destruct
    function kill() onlyOwner {
        selfdestruct(owner);
    }
}
