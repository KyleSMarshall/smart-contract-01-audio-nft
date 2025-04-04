// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract HireKyleNFT is ERC721 {

    uint256 public nextTokenId = 1;
    string private baseURI;

    event NFTMinted(address recipient, uint256 tokenId);

    constructor(string memory _baseURI) ERC721("HireKyleMarshall", "HKM") {
        baseURI = _baseURI;  // Store the base URI pointing to the metadata
    }

    function mintNFT() public {
        uint256 tokenId = nextTokenId;
        _safeMint(msg.sender, tokenId);
        nextTokenId++;

        emit NFTMinted(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        string memory currentBaseURI = baseURI;
        if (bytes(currentBaseURI).length > 0) {
            return string.concat(currentBaseURI, "nft_metadata.json"); // Use the actual filename
        } else {
            return "";
        }
    }
}