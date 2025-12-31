// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip} from "../src/CoinFlip/CoinFlip.sol";
import {CoinFlipAttacker} from "../src/CoinFlip/CoinFlipAttacker.sol";

contract CoinFlipScript is Script {
    CoinFlip public coinFlip;
    CoinFlipAttacker public coinFlipAttacker;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        coinFlip = CoinFlip(0xbd3259c8c5CbD3bc7E3B909733736509b8Dceca1);
        coinFlipAttacker = CoinFlipAttacker(0xcfa07182B64367a11033ECBaa6B9b3D962D2E113);

        coinFlipAttacker.attackCoinFlip();
        console.log("here is the wins: %s", coinFlip.consecutiveWins());
        vm.stopBroadcast();
    }
}
