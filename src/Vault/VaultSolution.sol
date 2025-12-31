// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaultSecure {
    bool public locked;
    bytes32 private passwordHash;

    constructor(bytes32 _passwordHash) {
        locked = true;
        // Store the hash of the password instead of the plain text password
        passwordHash = _passwordHash;
    }

    function unlock(bytes32 _password) public {
        // Hash the user's input and compare it to the stored hash
        if (keccak256(abi.encodePacked(_password)) == passwordHash) {
            locked = false;
        }
    }
}
