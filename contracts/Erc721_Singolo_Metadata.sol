/*
DevThree Production.

We are not affiliated with any project or team.

We are DEV paid for build all the teams want.

We are not responsible for the integrity and seriousness of the project.

*/

//SPDX-License-Identifier: DevThreeOfficial


pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;


  uint256 public cost = 1 ether;
  uint256 public maxSupply = 3;
  bool public paused = false;
  string  BaseURI = "https://ipfs.io/ipfs/QmcxRhk3v6AH37dfprEJctjq3Lqcmd3H9Qn2P4qkCiLPJ3";

  constructor() ERC721("_name", "_symbol") {}

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return BaseURI;
  }

  // public
  function mint() public payable {
    uint256 supply = totalSupply();
    require(!paused);
    require(supply  <= maxSupply - 1);

    if (msg.sender != owner()) {
        {
          require(msg.value >= cost);
        }
    }

   
      _safeMint(msg.sender, supply++);

  }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }



function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return BaseURI;
    }

  //only owner
 
  
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  //function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
    //maxMintAmount = _newmaxMintAmount;
  //}
  

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    BaseURI = _newBaseURI;
  }


  function pause(bool _state) public onlyOwner {
    paused = _state;
  }
 

  function withdraw() public payable onlyOwner {
   
    //(bool hs, ) = payable(msg.sender).call{value: address(this).balance * 5 / 100}("");
    //require(hs);
  
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    // =============================================================================
  }
}

