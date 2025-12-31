# Coin Flip Challenge

## Objective

1. We need to guess the outcome of the coinflip 10 times in a row

## Challenge: Guessing a Random Value

In Solidity, there is no out of the box random function that we can use, so this contract decided to compute the random value using this function:

``` solidity
uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
uint256 blockValue = uint256(blockhash(block.number - 1));
uint256 coinFlip = blockValue / FACTOR;
```
We can see here that both of block number and factor are known, so this value can be computed ahead, which makes this a security vulnerability because we can predict the value of coinFlip ahead.


## Implementation

The easiest way to win this game is to implement a smart contract that would compute the value of coinFlip using the current block number. we need to trigger this function 10 times, however, we need to wait the minting of a new block before triggering the function again.


## Deployment

**Contract on Sepolia:** `0xbd3259c8c5CbD3bc7E3B909733736509b8Dceca1`

**Exploit contract on Sepolia:** `0xcfa07182B64367a11033ECBaa6B9b3D962D2E113`

**Proper Randomness Contract on Sepolia:** `0x66aeb81076C8Bd9210D160a76486d9AB8413cFDb`

Check the script under `script/CoinFlip.s.sol`, you can run it using:

```sh
forge script script/CoinFlip.s.sol:CoinFlipScript --rpc-url $RPC_URL
```

## How to Avoid

In order to avoid this, we can rely on Chainlink's VRF (Verifiable Random Functions), Feel free to read it more thoroughly in these docs: [Chainlink VRF](https://docs.chain.link/vrf)
Chainlink provides a contract that interacts with oracles in order to generate a random number.

Please check `./CoinFlipSolution.sol` for a basic implementation of the coinFlip game with right randomness generation
