// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract HireKyleNFT is ERC721  {

    uint256 public nextTokenId = 1;
    string private baseURI;

    event NFTMinted(address recipient, uint256 tokenId);

    constructor(string memory _baseURI) ERC721("HireKyleMarshall", "HKM") {
        baseURI = _baseURI;
    }
    
    function mintNFT() public {
        uint256 tokenId = nextTokenId;
        _safeMint(msg.sender, tokenId);
        nextTokenId++;

        emit NFTMinted(msg.sender, tokenId);
    }
}

