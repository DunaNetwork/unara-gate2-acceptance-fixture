// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract ReliabilityOrderTest is Test {
    function test_alpha() public pure {
        assertEq(uint256(1), 1);
    }

    function test_beta() public pure {
        assertEq(uint256(2), 2);
    }
}

contract ReliabilityTimeoutTest is Test {
    function test_fastCase() public pure {
        assertTrue(true);
    }

    function test_slowCaseDeadline() public {
        vm.sleep(60_000);
    }
}
