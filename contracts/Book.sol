pragma solidity ^0.4.0;


contract Book {

    bytes32 public title;
    bytes32 public author;
    address public owner;
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
