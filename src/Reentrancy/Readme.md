# Reentrancy Challenge

## Objective

1. We need to steal all the funds of a contract

## Challenge: How to steal funds from a contract

In the `Reentrancy` contract, calling the `withdraw()` function does the following in order:
1. checks whether the address has balance in the contract
2. sends eth to the address through `msg.sender.call{value: _amount}("")`
3. updates the balance value in the contract.

The issue in this contract is at the second step, if the address is a smart contract, then `msg.sender.call{value: _amount}("")` triggers the receive function, a malicious user can use the receive function and infinitely call the Reentrancy.withdraw(), __never reaching__ the __step 3__, in other words always fulfilling the first step (_balance is always greater than amount_).




## Implementation

To exploit this, create a smart contract that:
1. Calls `withdraw()` to start the process.
2. In its `receive()` function, calls `withdraw()` again if the target contract still has funds.

See `./ReentrancyAttack.sol` for the attack code.

## How to Avoid

### 1. Checks-Effects-Interactions Pattern
Always update the state (Effects) **before** making any external calls (Interactions).
```solidity
balances[msg.sender] -= _amount;  // Effect
(bool result,) = msg.sender.call{value: _amount}(""); // Interaction
```
See ./ReentrancySolution.sol for the fixed implementation.

### 2. Reentrancy Guard
Use a modifier like OpenZeppelin's nonReentrant. This locks the contract during execution, preventing recursive calls to protected functions.

```solidity
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SecureContract is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function withdraw() public nonReentrant {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}
```