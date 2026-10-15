// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {InvestigationTarget} from "../src/InvestigationTarget.sol";

contract InvestigationTargetTest is Test {
    InvestigationTarget target;

    function setUp() public {
        target = new InvestigationTarget();
    }

    function test_standardRevert() public {
        vm.expectRevert(bytes("insufficient balance"));
        target.withdraw(1);
    }

    function test_customError() public {
        target.deposit(101);
    }
}
