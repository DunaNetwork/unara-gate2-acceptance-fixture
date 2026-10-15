// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract PinnedForkTest is Test {
    address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function test_pinnedForkState() public {
        uint256 pinned = vm.envUint("UNARA_DECLARED_FORK_BLOCK_NUMBER");
        vm.createSelectFork("staging-ethereum-mainnet", pinned);
        assertEq(block.chainid, 1);
        assertEq(block.number, pinned);
        assertGt(WETH.code.length, 0);

        uint256 originalBalance = address(this).balance;
        uint256 parentSnapshot = vm.snapshot();
        vm.deal(address(this), originalBalance + 1 ether);
        assertEq(address(this).balance, originalBalance + 1 ether);

        uint256 childSnapshot = vm.snapshot();
        bytes32 slot = bytes32(uint256(1));
        vm.store(address(this), slot, bytes32(uint256(7)));
        assertEq(uint256(vm.load(address(this), slot)), 7);
        uint256 timestamp = block.timestamp;
        vm.warp(timestamp + 15);
        vm.roll(pinned + 1);
        assertEq(block.timestamp, timestamp + 15);
        assertEq(block.number, pinned + 1);
        vm.prank(address(0xBEEF));
        (bool ok,) = WETH.staticcall(abi.encodeWithSignature("name()"));
        assertTrue(ok);

        assertTrue(vm.revertTo(childSnapshot));
        assertEq(address(this).balance, originalBalance + 1 ether);
        assertEq(uint256(vm.load(address(this), slot)), 0);
        assertEq(block.number, pinned);
        assertEq(block.timestamp, timestamp);

        assertTrue(vm.revertTo(parentSnapshot));
        assertEq(address(this).balance, originalBalance);

        emit log_named_uint("UNARA_PARENT_SNAPSHOT", parentSnapshot);
        emit log_named_uint("UNARA_CHILD_SNAPSHOT", childSnapshot);
    }
}
