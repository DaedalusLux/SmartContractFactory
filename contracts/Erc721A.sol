// SPDX-License-Identifier: BourbonKelly

pragma solidity >=0.7.0 <0.9.0;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaseNFT is ERC721A, Ownable{
    using Strings for uint256;
    uint256 public maxSupply = 2500;
    string private baseURI = "Your Ipfs";
    string private  baseExtension = ".json";

    constructor() ERC721A( "Your Name", "Your Symbol") {}


 function mint (uint256 quantity) external  payable onlyOwner  {
   uint256 supply = totalSupply();
   require(supply <= maxSupply, 'too much');
    _mint(msg.sender, quantity);
   supply++;
    
    }

function _baseURI() override  internal view  virtual  returns(string memory) {
    return baseURI;
}

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    


    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

    function withdraw() public payable onlyOwner {
   
    //(bool hs, ) = payable(msg.sender).call{value: address(this).balance * 5 / 100}("");
    //require(hs);
  
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    // =============================================================================
  }
}