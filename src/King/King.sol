// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract UltimateKing {
    address public kingContract;
    bool public receivedMoney;
    constructor(address _kingContract) {
        kingContract = _kingContract;
        receivedMoney = false;
    }

    function sendFunds() payable external {
        (bool success, ) = payable(kingContract).call{value: msg.value}("");
        require(success, "Failed to send");
    }
}