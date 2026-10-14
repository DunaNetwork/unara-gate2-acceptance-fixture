// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Ledger} from "../src/Ledger.sol";

contract LedgerHandler is Test {
    Ledger public ledger;

    constructor(Ledger ledger_) {
        ledger = ledger_;
    }

    function deposit(uint96 amount) external {
        ledger.deposit(amount);
    }

    function mark() external {
        ledger.mark();
    }

    function withdraw(uint96 amount) external {
        uint256 balance = ledger.balances(address(this));
        if (amount > balance) return;
        ledger.withdraw(amount);
    }
}

contract LedgerInvariant is Test {
    Ledger ledger;
    LedgerHandler handler;

    function setUp() public {
        ledger = new Ledger();
        handler = new LedgerHandler(ledger);
        targetContract(address(handler));
    }

    function invariant_totalMatchesBalances() public view {
        assertEq(ledger.total(), ledger.balances(address(handler)));
    }
}