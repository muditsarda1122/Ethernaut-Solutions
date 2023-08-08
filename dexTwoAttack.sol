//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

//token address - 0xcE8FE0E8f5A09fc0AbFbA0b2c2172a243D886200
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AngelCoin is ERC20 {
    constructor(uint256 _initialSupply) ERC20("AngelCoin", "AC") {
        _mint(msg.sender, _initialSupply);
    }
}
