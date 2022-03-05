// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./Owner.sol";

contract Authority is Owner {
    event NewAuthority(address authority);
    event RemovedAuthority(address authority);

    mapping(address => bool) isAuthority;
    mapping(address => string) authorityMetadata;

    modifier onlyAuthority() {
        require(isAuthority[msg.sender] == true, "Caller is not authority");
        _;
    }

    function addAuthority(address _authority, string memory _metadata)
        public
        isOwner
    {
        require(isAuthority[_authority] != true, "Already authority");
        isAuthority[_authority] = true;
        authorityMetadata[_authority] = _metadata;
        emit NewAuthority(_authority);
    }

    function removeAuthority(address _authority) public isOwner {
        require(isAuthority[_authority] == true, "is not authority");
        isAuthority[_authority] = false;
        emit RemovedAuthority(_authority);
    }
}
