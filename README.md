# Ethernaut Challenges Solutions

This repository contains comprehensive solutions, detailed explanations, and security fixes for the [Ethernaut](https://ethernaut.openzeppelin.com/) challenges.

## Purpose

The goal of this repository is not just to solve the levels, but to understand the underlying vulnerabilities. For each challenge located in the `src/` directory, you will find:

1.  **Analysis**: A `README.md` explaining the vulnerability, the objective, and the solution.
2.  **The Code**: The original challenge contract.
3.  **The Exploit**: A contract (`*Attack.sol`) or script used to hack the level.
4.  **The Fix**: A secure implementation (`*Solution.sol`) demonstrating how to avoid the vulnerability in production.

## Tools Used

This project exploits and solves challenges using **Foundry**.

- **Cast**: Used for interacting with the chain, sending transactions, and inspecting storage slots (crucial for reading `private` variables).

// TODO: talk about cas tand cast command
// TODO: explain the difference betwen verified and unverified contract