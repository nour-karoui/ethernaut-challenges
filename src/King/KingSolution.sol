// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingSecure {
    address public king;
    uint256 public prize;
    address public owner;

    // Mapping to store balances for the withdrawal pattern
    mapping(address => uint256) public balances;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);

        // Instead of transferring to the current king immediately (which causes the vulnerability),
        // we store the amount in the balances mapping.
        // The outgoing king can then withdraw their funds later.
        balances[king] += msg.value;

        king = msg.sender;
        prize = msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");

        balances[msg.sender] = 0;

        (bool sent,) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function _king() public view returns (address) {
        return king;
    }
}
