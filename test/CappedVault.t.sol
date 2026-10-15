// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CappedVault} from "../src/CappedVault.sol";

contract CappedVaultTest is Test {
    CappedVault vault;

    function setUp() public {
        vault = new CappedVault();
    }

    function testFuzz_depositRespectsCap(uint256 amount) public {
        vault.deposit(amount);
        assertLe(vault.balance(), vault.CAP());
    }

    /// @notice UNARA kept-regression v1
    /// @dev review accepted. Source failure d2600bbf-845b-4ec5-9e9a-4d76431510db. Minimized counterexample 101.
    function test_regression_depositRespectsCap() public {
        vault.deposit(101);
        assertLe(vault.balance(), vault.CAP());
    }
}