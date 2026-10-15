// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ledger {
    mapping(address => uint256) public balances;
    uint256 public total;
    uint256 public marks;

    function deposit(uint256 amount) external {
        balances[msg.sender] += amount;
        total += amount;
    }

    function mark() external {
        marks += 1;
    }

    function withdraw(uint256 amount) external {
        balances[msg.sender] -= amount;
        total -= amount;
    }
}