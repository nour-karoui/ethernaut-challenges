# Fallback Challenge

## Objectives

1. Claim ownership of the contract
2. Steal the contract's balance

The contract provides a `withdraw()` method that transfers the contract's funds to the owner.

## Challenge: Claiming Ownership

In Solidity, there are two special functions that handle direct contract interactions:

### 1. `receive()` Function

The `receive()` function must be marked `payable`. It provides a straightforward way to send ether to a contract:

```solidity
payable(contractAddress).call{value: amount}("")
```

### 2. `fallback()` Function

The `fallback()` function is executed when:
- You call a contract with data that doesn't match any existing function signature
- If marked `payable`, it's also executed when sending ETH to the contract

## Key Behaviors

**When both `receive()` and `fallback()` are defined:**
- `receive()` executes for empty data calls
- `fallback()` executes for non-empty data calls

**When neither is defined:**
- There's no way to send ETH to the contract except through payable functions (or in edge cases if the contract address is as a recipient of a coinbase transaction (aka miner block reward) or as a destination of a selfdestruct)

### Gas Limitations

When using `receive() payable` or `fallback() payable`, only 2300 gas is forwarded to the recipient, which restricts operations.

Operations restricted by 2300 gas include:
- Writing to storage
- Creating a contract
- Calling external functions with high gas consumption
- Sending Ether

---

**Reference:** [Solidity Special Functions Documentation](https://docs.soliditylang.org/en/v0.8.33/contracts.html#special-functions)


## Implementation

The easiest way to claim ownership of this contract is to contribute and then send eth directly. The receive function will get executed, checking whether the msg.sender already contributed, if yes, it assigns it as the new owner.


## Deployment

**Contract on Sepolia:** `0x3C0606f6a588d4e089E91E9D6805a5ef35714fB3`

**Exploit contract on Sepolia:** `0x4cd13a9fdb0923d4cf470ed7293942262954bba3`

## How to Avoid

Remove the `owner = msg.sender` assignment in the `receive()` function. This prevents reassigning ownership when ETH is sent directly to the contract.

