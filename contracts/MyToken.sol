// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC721, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct AudioMetadata {
        string name;
        string hash;
        bool isValidHash;
    }

    mapping(uint256 => AudioMetadata) public metadata;

    string private baseURI;

    event AudioLinkGenerated(uint256 tokenId, string name, string hash);
    event AudioLinkUsed(uint256 tokenId);
    event TokenRenewed(uint256 tokenId, string newHash);

    constructor(string memory _name, string memory _symbol, string memory _baseURI) ERC721(_name, _symbol) {
        baseURI = _baseURI;
    }
    
    // Generate one-time use audio link
    function generateAudioLink(string memory _name, string memory _hash) public onlyOwner {
        require(bytes(_name).length > 0, "Name must not be empty.");
        require(bytes(_hash).length > 0, "Hash must not be empty.");

        _tokenIds.increment();
        uint256 _newTokenId = _tokenIds.current();

        metadata[_newTokenId] = AudioMetadata({
            name: _name, 
            hash: _hash,
            isValidHash: true
        });

        _safeMint(msg.sender, _newTokenId);
        emit AudioLinkGenerated(_newTokenId, _name, _hash);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721: URI query for nonexistent token");

        return string.concat(baseURI, Strings.toString(tokenId));
    }

    function invalidateToken(uint256 tokenId) public onlyOwner {
        require(_exists(tokenId), "ERC721: Invalidation for nonexistent token");
        metadata[tokenId].isValidHash = false;
    }

    function setBaseURI(string memory _baseURI) public onlyOwner {
        baseURI = _baseURI;
    }


}
