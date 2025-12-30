# Fal1out Challenge

## Objective

1. Claim ownership of the contract

## Challenge: Claiming Ownership

Before solidity __0.4.22__, the constructor used to be called the same as the smart contract name, which open doors to a security vulnerability, if the contract name changes and the constructor is not updated, it would now become an ordinary function everyone can call

```solidity
pragma solidity ^0.4.21;

contract lIve {
    address payable owner;
    llve() {
        owner = msg.sender;
    }
}
```
This actually happened before, the story of Rubixi is a very well known case in the Ethereum ecosystem. The company changed its name from 'Dynamic Pyramid' to 'Rubixi' but somehow they didn't rename the constructor method of its contract:

```solidity
contract Rubixi {
  address private owner;
  function DynamicPyramid() { owner = msg.sender; }
  function collectAllFees() { owner.transfer(this.balance) }
  ...

```

This allowed the attacker to call the old constructor and claim ownership of the contract, and steal some funds. Yep. Big mistakes can be made in smartcontractland.

## Implementation

The easiest way to claim ownership of this contract is to call the `Fal1out()` function that looks like the constructor, but is not.


## How to Avoid
Since solidity __0.4.22__ the constructor was renamed to _constructor_ to avoid any kind of confusion and human mistake.
