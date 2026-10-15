// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract InvestigationTarget {
    error CapExceeded(uint256 amount, uint256 cap);

    event Deposited(address indexed who, uint256 amount);

    uint256 public constant CAP = 100;
    uint256 public balance;

    function deposit(uint256 amount) external {
        uint256 accepted = amount > CAP ? CAP : amount;
        balance = accepted;
        emit Deposited(msg.sender, accepted);
    }

    function withdraw(uint256 amount) external {
        require(amount <= balance, "insufficient balance");
        balance -= amount;
    }
}
