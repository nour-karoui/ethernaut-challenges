// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import {
    VRFV2PlusWrapperConsumerBase
} from "@chainlinkcontracts/lib/chainlink-brownie-contracts/contracts/src/v0.8/dev/vrf/VRFV2PlusWrapperConsumerBase.sol";

address constant LINK_ADDRESS = 0x779877A7B0D9E8603169DdbD7836e478b4624789;
address constant VRF_WRAPPER_ADDRESS = 0xab18414CD93297B0d12ac29E63Ca20f515b3DB46;

interface ERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external;
    function transfer(address spender, uint256 amount) external;
}

contract CoinFlip is VRFV2PlusWrapperConsumerBase {
    address public owner;
    uint256 public consecutiveWins;
    uint256 public lastRandomNumber;
    bool public gameStarted;
    bool public currentGuess;

    constructor() VRFV2PlusWrapperConsumerBase(LINK_ADDRESS, VRF_WRAPPER_ADDRESS) {
        consecutiveWins = 0;
        gameStarted = false;
        owner = msg.sender;
    }

    function flip(bool _guess) public {
        require(
            ERC20(LINK_ADDRESS).balanceOf(address(this)) > 0,
            "You don't have enough balance to generate a random number"
        );
        if (!gameStarted) gameStarted = true;
        currentGuess = _guess;
        requestRandomness(100_000, 3, 1);
    }

    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        require(gameStarted, "The game has not started yet!");
        lastRandomNumber = _randomWords[0] % 2;
        bool side = lastRandomNumber == 1 ? true : false;
        if (side == currentGuess) {
            consecutiveWins++;
        } else {
            consecutiveWins = 0;
        }
    }

    function approveLink() external {
        ERC20(LINK_ADDRESS).approve(VRF_WRAPPER_ADDRESS, ERC20(LINK_ADDRESS).balanceOf(address(this)));
    }

    function transferLinkToOwner() external {
        ERC20(LINK_ADDRESS).approve(owner, ERC20(LINK_ADDRESS).balanceOf(address(this)));
        ERC20(LINK_ADDRESS).transfer(owner, ERC20(LINK_ADDRESS).balanceOf(address(this)));
    }
}
