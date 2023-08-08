// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./switch.sol";

contract SwitchAttack {
    Switch public target;

    constructor(address adr) {
        target = Switch(adr);
    }
}
