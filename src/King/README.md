# King Challenge

## Objective

1. We need to become the King and ensure that no one else can overthrow you (claim the kingship) after that.

## Challenge: Becoming the Undethrownable King 

As explained thoroughly in Force and Fallback, the __ONLY__ way to transfer ether to a contract with `payable(address).transfer(amount)` is to have the contract implement the `receive()` or `fallback()` payable function.

The `transfer` function reverts the entire transaction if the transfer fails.



## Implementation

If the current king is a smart contract that **cannot receive Ether** (either because it has no `receive`/`fallback` function, or because it explicitly reverts in those functions), the `transfer` will fail. Since the transfer happens inside the main logic, the failure causes the entire `receive` function of the `King` contract to revert. This prevents anyone else from becoming the new king.

That way if someone tries to overthrow the contract, the function would revert at this level:
`payable(king).transfer(msg.value)`



## How to Avoid

This vulnerability happens because the contract relies on an external call (`transfer`) to succeed in order to complete its own state change. This is a "Push" pattern.

To fix this, use the **Pull over Push** (Withdrawal) pattern:
1. Instead of sending Ether immediately, store the amount owed to the previous king in a mapping (e.g., `balances[previousKing] += prize`).
2. Create a separate `withdraw()` function that allows users to claim their stored balance.

This ensures that even if one user's withdrawal fails (or is malicious), it does not block the main contract logic for everyone else.

Please refer to `./KingSolution.sol` for the proper King implementation