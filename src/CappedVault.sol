// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CappedVault {
    uint256 public constant CAP = 100;
    uint256 public balance;

    function deposit(uint256 amount) external {
        uint256 accepted = amount > CAP ? CAP : amount;
        balance += accepted;
    }
}