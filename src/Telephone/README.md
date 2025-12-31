# Telephone Challenge

## Objective

1. We need to claim ownership of this smart contract

## Challenge: Claiming Ownership

In Solidity, there are two important globals for authentication:
- `msg.sender`: The address that immediately called the current function. This can be an EOA (Externally Owned Account) or a smart contract.
- `tx.origin`: The address of the EOA that originally initiated the transaction. This is always an EOA.


## Implementation

The easiest way to claim ownership of this contract, is to have the `msg.sender` different from `tx.origin`, by simply calling a function in another smart contract that would trigger `changeOwner()`. please check `./TelephoneThief.sol` for the exploit implementation.

To exploit this, we need to create an intermediate contract (like TelephoneThief.sol) that calls Telephone.changeOwner.
1. You (EOA) call TelephoneThief.stealTelephone().
2. TelephoneThief calls Telephone.changeOwner().

Inside Telephone:
•  tx.origin is You (EOA).
•  msg.sender is TelephoneThief (Contract).

## How to Avoid

Generally `tx.origin` is not used and we generally use `msg.sender`, please refer to solidity's documentation for further explanation, [tx.origin vulnerability](https://docs.soliditylang.org/en/v0.8.33/security-considerations.html#tx-origin).

