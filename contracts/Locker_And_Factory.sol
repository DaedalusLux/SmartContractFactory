//SPDX-License-Identifier: DevThree

pragma solidity 0.8.16;

contract Lock {
    uint public unlockTime;
    address payable public owner;
    address payable immutable creator = payable(0x5B81c5DB3ef58C7ae778b11D6954BD13377e6BFD);
    address public locker;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime, address _owner) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(_owner);
        locker = address(this);
    }

function extendTime(uint256 newUnlockTime) public {
    require(msg.sender == owner);
    require(unlockTime < newUnlockTime);
    require(newUnlockTime > block.timestamp);

    unlockTime = newUnlockTime;

}


function getTime() public view returns(uint256){
    return block.timestamp;
}
    function withdraw() public {
       

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        creator.transfer(((address(this).balance) * 10)/100);
        owner.transfer(address(this).balance);

    }
}

contract FactoryLock {

    Lock[] public lockers;

    function createLocker(uint256 UnlockTime, address owner) external payable{
        Lock lock = new Lock{value: msg.value}(UnlockTime, owner);
        lockers.push(lock);
    }

    function getAddress(uint256 _index) public view returns(address locker){

        Lock lock =lockers[_index];
        return lock.locker();
    }

    function getTime() public view returns(uint256){
    return block.timestamp;
}
    
    }