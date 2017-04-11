pragma solidity ^0.4.8;

contract Book {

    // each instance of this contract represents a physical book 
    // this contract will store the deposits
    // and distribute rewards according to user interaction

    // Current Tx State
    // WHOS THE ARBITER?
    address public arbiter;
    address public borrower;

    // Book State
    bytes32 public isbn;
    address public owner;

    enum Status { Available, Unavailable }
    Status public status;

    // Modifiers
    modifier onlyOwner { if(msg.sender != owner) throw; _; }

    // Events
    

    // Constructor
    function Book(bytes32 _isbn, address _owner, address _arbiter) {
        owner = _owner;
        isbn = _isbn;
        status = Status.Available;
        arbiter = _arbiter;
    }

    function checkout() returns (Status) {
        if (status == Status.Available) {
            status = Status.Unavailable;
        }
        /* 
            charge both parties a 2BKC deposit
        */
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

    // Get current balance on this contract
    function getBalance() constant returns (uint) {
        return this.balance;
    }

    // contract self-destruct
    // ??? should arbiter be able to kill ???
    function kill() onlyOwner {
        selfdestruct(owner);
    }
}
