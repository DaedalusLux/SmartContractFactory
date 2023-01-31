//SPDX-License-Identifier: DevThree


pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiSenderT is Ownable {

event sent (address[], uint256);


function verifyAllowance(address SmartContract, uint256 quantity) internal {
    
    ERC20(SmartContract).increaseAllowance(address(this), quantity);
}



function Multi (address[] memory wallet, address token, uint256 value) external onlyOwner {
    
     verifyAllowance(token, value * wallet.length);
    for (uint256 i = 0; i < wallet.length; i++){
      

        ERC20(token).transferFrom(address(this), wallet[i], value);
        emit sent(wallet, value);
    }
}
    
}