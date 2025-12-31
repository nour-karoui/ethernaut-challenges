# Vault Challenge

## Objective

1. We need to unlock this contract by guessing the password

## Challenge: Reading private values on chain

In Solidity, the `private` visibility modifier only prevents other contracts from accessing the variable. It **does not** hide the data from the blockchain. Since the blockchain is a public ledger, anyone can inspect the storage of a contract to read its values

### Storage Layout
State variables in Solidity are stored in 32-byte slots.
1. `bool public locked`: Occupies Slot 0.
2. `bytes32 private password`: Occupies Slot 1.

Even though `password` is marked private, we can read the raw data from Slot 1 using a tool like `cast`.

## Solution

1. **Read the password from storage:**
   Use `cast storage` to read the value at slot 1.
   ```bash
   cast storage <CONTRACT_ADDRESS> 1

## How to Avoid

- Never store sensitive data (passwords, API keys, user privacy data) on-chain in plain text. private variables are not secret.
- If you must verify a secret on-chain, store a hash of the secret (e.g., keccak256(password)) and verify the hash of the user's input.
- Please refer to `./VaultSolution.sol` for the proper password implementation.
