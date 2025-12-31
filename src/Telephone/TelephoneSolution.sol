// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            revert("This is risky, you cannot become the owner like this!");
        }
    }
}
