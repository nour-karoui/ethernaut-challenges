// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force { /*
                   MEOW ?
         /\_/\   /
    ____/ o o \
    /~____  =ø= /
    (______)__m_m)
                   */ 
                  
}


contract BForce {
     constructor() payable {
        // Contract receives ETH on deployment
    }
    
    function attack(address target) external {
        // Forces all ETH in this contract to the target
        selfdestruct(payable(target));
    }
}