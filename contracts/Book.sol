pragma solidity ^0.4.10;

contract Book {

    // each instance of this contract represents a physical book 
    // this contract will store the deposits
    // and distribute rewards according to user interaction

    bytes32 public title;
    bytes32 public author;
    address public owner;
    string public image_url; //ipfs?

    enum Status { Available, Unavailable }
    Status public status;

    function Book(bytes32 _title, bytes32 _author) {
        owner = msg.sender;
        title = _title;
        author = _author;
        status = Status.Available;
    }

    function checkout() returns (Status) {
        if (status == Status.Available) {
            status = Status.Unavailable;
        }
        return status;
    }

    function returnBook() returns (Status) {
        if (status == Status.Unavailable) {
            status = Status.Available;
        }
        return status;
    }

    function isAvailable() constant returns (bool) {
        if (status == Status.Available) {
            return true;
        } else {
            return false;
        }
    }
}
