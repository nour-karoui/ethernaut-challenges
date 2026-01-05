# Ethernaut Challenges Solutions

This repository contains comprehensive solutions, detailed explanations, and security fixes for the [Ethernaut](https://ethernaut.openzeppelin.com/) challenges.

## Purpose

The goal of this repository is not just to solve the levels, but to understand the underlying vulnerabilities. For each challenge located in the `src/` directory, you will find:

1.  **Analysis**: A `README.md` explaining the vulnerability, the objective, and the solution.
2.  **The Code**: The original challenge contract.
3.  **The Exploit**: A contract (`*Attack.sol`) or script used to hack the level.
4.  **The Fix**: A secure implementation (`*Solution.sol`) demonstrating how to avoid the vulnerability in production.

## Tools Used

This project exploits and solves challenges using **Foundry** framework.

### Cast

**Cast** is a command-line tool used for interacting with the blockchain. It's essential for:
- Sending transactions to execute exploit functions
- Calling view/pure functions to inspect contract state
- Reading private variables via storage slot inspection

For more information, refer to the [Foundry documentation](https://getfoundry.sh/).

### Popular Cast Commands

- **Send a transaction**: `cast send <CONTRACT_ADDRESS> "functionName(params)" paramvalue --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>`
  - Executes a state-changing function on the blockchain

- **Call a view/pure function**: `cast call <CONTRACT_ADDRESS> "functionName(params)" paramvalue --rpc-url <RPC_URL>`
  - Reads contract state without broadcasting a transaction

- **Check an address's balance**: `cast balance <ADDRESS> --ether --rpc-url <RPC_URL>`
  - Retrieves the ETH balance of a given address

- **Read storage slots**: `cast storage <CONTRACT_ADDRESS> <SLOT_NUMBER> --rpc-url <RPC_URL>`
  - Inspects the raw storage of a contract, useful for accessing private variables

### Deploying and Verifying Contracts

**Deploy a contract with verification**:
```bash
forge create PATH_TO_FILE/FILENAME.sol:CONTRACT_NAME --rpc-url $RPC_URL \
--private-key PRIVATE_KEY \
--verify \
--broadcast \
--etherscan-api-key $ETHERSCAN_API_KEY \
--constructor-args CONSTRUCTOR_ARGS
```

**Verify a deployed contract**:
```bash
forge verify-contract <CONTRACT_ADDRESS> <PATH_TO_FILE/FILENAME.sol:CONTRACT_NAME> --rpc-url $RPC_URL \
--etherscan-api-key $ETHERSCAN_API_KEY \
--constructor-args CONSTRUCTOR_ARGS
```

### Verification a smart contract's source code

Since the EVM (Ethereum Virtaul Machine) cannot read high level languages (solidity), a developer has to compile the smart contract into bytecode (low level language) before deploying the smart contract.

Source code verification is comparing the compiled bytecode to the source code provided to ensure that the deployed contract matches what the developer claims it to be. In other words, verifying a smart contract allows to link variables and functions to their human readable name.

Please refer to the [ethereum documentation](https://ethereum.org/developers/docs/smart-contracts/verifying/) for further details.

- **Verified contracts**: Source code is published on block explorers (like Etherscan), allowing anyone to inspect and interact with the contract directly from the interface. Verification is important for transparency and security audits.

- **Unverified contracts**: Only the bytecode is visible on block explorers. While the contract still functions normally, users cannot easily read or audit the source code, making it harder to understand what the contract does.

For these challenges, sometimes I had to redeploy the smart contract and verify it to be able to better debug it, as the instances provided by the challenge are never verified.

