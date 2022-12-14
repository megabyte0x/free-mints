// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FreeMints is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenId;

    //* Address => Their Minted NFT (TokenId => Token URI)
    mapping(address => mapping(uint256 => string)) public uriMap;

    constructor() ERC721("Free Mints", "FM") {}

    event Minted(address indexed to, uint256 indexed tokenId, string indexed uri);

    function mint(address _to, string memory _tokenURI) external {
        uint256 tokenId = _tokenId.current();

        _safeMint(_to, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        uriMap[_to][tokenId] = _tokenURI;
        
        emit Minted(_to, tokenId, _tokenURI);

        _tokenId.increment();
    }
}
