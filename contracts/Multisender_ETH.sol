//SPDX-License-Identifier: DevThree

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiSender  is Ownable {

 receive() external payable {}
 fallback() external payable {}

 function fund() external payable{

 }

 function getBalance() public view returns (uint) {
    return address(this).balance;
    }

function Multi(address payable[] memory _to, uint256 value) public payable onlyOwner {
   
     require(address(this).balance >= value, "too much");
for(uint256 i = 0; i < _to.length; i++){
        (bool sent, ) = _to[i].call{value: value}("");
        require(sent, "Failed to send Ether");}
    }

function EmergencyWithdraw() public payable onlyOwner {
    
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
   
  }
    
}