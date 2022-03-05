// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract Owner {
    address private owner;

    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }

    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}