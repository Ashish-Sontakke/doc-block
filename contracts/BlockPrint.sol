// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "./Authority.sol";

contract BlockPrint is Authority {
    event CreateDocument(string documentData, uint256 documentId);

    using Counters for Counters.Counter;
    Counters.Counter documentId;

    mapping(string => bool) private isDocumentMinted;
    mapping(uint256 => string) private idToDocumentData;
    mapping(uint256 => address) private issuer;

    function createDocument(string memory _documentData) public onlyAuthority {
        require(
            !isDocumentMinted[_documentData],
            "The document is already stored"
        );
        uint256 thisDocumentId = documentId.current();
        idToDocumentData[thisDocumentId] = _documentData;
        issuer[thisDocumentId] = msg.sender;
        isDocumentMinted[_documentData] = true;
        emit CreateDocument(_documentData, thisDocumentId);
        documentId.increment();
    }

    function getDocument(uint256 _documentId)
        public
        view
        returns (string memory)
    {
        return idToDocumentData[_documentId];
    }

    function getIssuerAddress(uint256 _documentId)
        public
        view
        returns (address)
    {
        return issuer[_documentId];
    }

    function getIssuerData(uint256 _documentId)
        public
        view
        returns (string memory)
    {
        address issuerAddress = getIssuerAddress(_documentId);
        return authorityMetadata[issuerAddress];
    }

    function isDocumentCreated(string memory _documentData)
        public
        view
        returns (bool)
    {
        return isDocumentMinted[_documentData];
    }
}
