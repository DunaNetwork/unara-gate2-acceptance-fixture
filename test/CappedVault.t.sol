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
}