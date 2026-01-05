# Privacy Challenge

## Objective

1. We need to unlock this contract by guessing the right key

## Challenge: Reading value from chain

### Storage Slots

In Solidity, the way that variables are stored in a smart contract are in storage slots.
A storage slot is size of 32 bytes, and the variables are stored in compacted way. 
Here are the size for certain variable types:

- `uint256` requires __32 bytes__ which means _1 storage slot_.

- `uint8` requires __1 byte__ which means _1/32 storage slot_.

- `boolean` requires __1 bit__ which means _1/256 storage slot_.

- `address` requires __20 bytes__ which means _20/32 storage slot_.

if the current storage slot still has place for the current variable, we compact the current variable in the current storage slot.

The only exception here is __arrays and structs__, they always start in a new storage slot and the next variable is always in a new storage slot as well

so if we have this smart contract

```solidity
contract A {
    uint256 public x;
    uint8 public y;
    uint8 public z;
    bool public isValue;
    uint8[3] public values;
    ...
}
```
so this slot distribution for this contract would be as follows:
- _slot 0_ → __x__;

- _slot 1_ → __y,z, isValue__;

- _slot 2_ → __values__;

even though there is still spots in a slot 1 for the values array, but since it is an array, it always starts in a new slot.


Please refer to the documentation for a deeper explanation: [storage slots](https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html#layout-of-state-variables-in-storage-and-transient-storage)

### Casting

- Type casting is the process of converting one data type to another. In Solidity, type casting can be done explicitly by the developer using the syntax type(variable)
- Casting variables, might be too dangerous because we could lose information in casting.
- For example casting a `string` into `bytes32`, a string does not have a size limit, however, bytes32 only reads the first 32 bytes. same goes for `bytes16`, `bytes8`, etc…
- In the other hand, when you cast bytes32 to string, or bytes16 to bytes32 which adds trailing zeros to fulfill the 32 bytes space
- Casting bytes32 to bytes16, reads the first 16 bytes of the variable


Please refer to the documentation for a deeper explanation: [casting](https://docs.soliditylang.org/en/v0.8.16/types.html#explicit-conversions) 

## Implemetation

Let's calculate the slots in this smart contract:

```solidity
contract Privacy {
    bool public locked = true;
    uint256 public ID = block.timestamp;
    uint8 private flattening = 10;
    uint8 private denomination = 255;
    uint16 private awkwardness = uint16(block.timestamp);
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
    */
}
```

- _slot 0_ -> __locked__
- _slot 1_ -> __ID__
- _slot 2_ -> __flattening, denomination, awkwardness__
- _slot 3_ -> __data[0]__
- _slot 4_ -> __data[1]__
- _slot 5_ -> __data[2]__

So we are interested in the value of data[2], we can see that it exist in slot 5 => so in order to get that value we need to run:

`cast storage 5 <CONTRACT_ADDRESS>`

however, it doesn't stop there, the value we retrieved is `bytes32`, however, we need to cast it to `bytes16`, so we need to take the first 16 bytes of the 32 bytes value we just read.

then we call the function unlock with the casted value.