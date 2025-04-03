// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract HireKyleNFT is ERC721, Ownable {

    struct AudioMetadata {
        string name;
        string hash;
    }

    mapping(uint256 => AudioMetadata) public metadata;

    string private baseURI;

    event NFTMinted(uint256 tokenId, string name, string hash);

    constructor() ERC721("HireKyleMarshall", "HKM"){
        baseURI = _baseURI;
    }
    
    // Generate one-time use audio link
    function mintNFT(string memory _name, string memory _hash) public {
        require(bytes(_name).length > 0, "Name must not be empty.");
        require(bytes(_hash).length > 0, "Hash must not be empty.");

        uint256 newTokenId = _nextTokenId();

        metadata[newTokenId] = AudioMetadata({
            name: _name, 
            hash: _hash
        });

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, string.concat("ipfs://bafkreigfoddr27kurwiibcdwqgl3u66bd2gmg7qnkvtwh5r4ynv4cfom4m/", Strings.toString(newTokenId)));
        
        emit NFTMinted(newTokenId, _name, _hash);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721: URI query for nonexistent token");
        return string.concat(baseURI, Strings.toString(tokenId));
    }

    function setBaseURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }
}
