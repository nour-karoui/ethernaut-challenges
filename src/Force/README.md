# Force Challenge

## Objectives

The goal of this challenge is to send ether to the contract

## Challenge: Sending eth to a contract

As explained in the fallback challenge, there are only 3 ways to send ether to a contract:

1- through the `receive()` function
2- through a `fallback() payable` function
3- you can call a `payable function` in the contract

however there exists an exception to these 3 use cases, you can force send ether to a contract when its address is specified as the:
1- target of a `selfdestruct()` call
2- recipient of a coinbase transaction

## Implementation

The easiest way to send eth to this contract is to specify it as the target address of a `selfdesctruct()` call in another contract. Please refer to `./AttackForce.sol` for the exploit implementation.

