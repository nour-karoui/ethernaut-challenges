// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Building} from "./Elevator.sol";

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);
        bool isLastFloor = building.isLastFloor(_floor);
        if (!isLastFloor) {
            floor = _floor;
            top = isLastFloor;
        }
    }
}
