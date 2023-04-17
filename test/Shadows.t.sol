// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Shadows} from "../src/Shadows.sol";
import {ExpansionsRegistry} from "../src/ExpansionsRegistry.sol";

contract ShadowsTest is Test {
    event ExpansionSet(uint256 indexed tokenId, uint256 indexed slot, uint8 expansionId, uint16 itemId);

    Shadows public shadows;

    function setUp() public {
        shadows = new Shadows(address(new ExpansionsRegistry()));
        shadows.mint{value: 1 ether}(1);
    }

    // TESTS
    function testAll() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setBackground(1, newExpansionId, newItemId);
        _setHead(1, newExpansionId, newItemId);
        _setChest(1, newExpansionId, newItemId);
        _setShoulders(1, newExpansionId, newItemId);
        _setBack(1, newExpansionId, newItemId);
        _setAccessories(1, newExpansionId, newItemId);
        _setHand1(1, newExpansionId, newItemId);
        _setHand2(1, newExpansionId, newItemId);

        uint256 expansionId;
        uint256 itemId;

        (expansionId, itemId) = _background(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _head(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _chest(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _shoulders(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _back(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _accessories(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _hand1(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _hand2(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testAllFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setBackground(1, newExpansionId, newItemId);
        _setHead(1, newExpansionId, newItemId);
        _setChest(1, newExpansionId, newItemId);
        _setShoulders(1, newExpansionId, newItemId);
        _setBack(1, newExpansionId, newItemId);
        _setAccessories(1, newExpansionId, newItemId);
        _setHand1(1, newExpansionId, newItemId);
        _setHand2(1, newExpansionId, newItemId);

        uint256 expansionId;
        uint256 itemId;

        (expansionId, itemId) = _background(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _head(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _chest(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _shoulders(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _back(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _accessories(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _hand1(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);

        (expansionId, itemId) = _hand2(1);
        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testBackground() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setBackground(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _background(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testBackgroundFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setBackground(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _background(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHead() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setHead(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _head(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHeadFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setHead(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _head(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testChest() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setChest(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _chest(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testChestFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setChest(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _chest(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testShoulders() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setShoulders(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _shoulders(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testShouldersFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setShoulders(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _shoulders(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testBack() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setBack(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _back(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testBackFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setBack(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _back(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testAccessories() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setAccessories(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _accessories(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testAccessoriesFuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setAccessories(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _accessories(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHand1() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setHand1(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _hand1(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHand1Fuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setHand1(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _hand1(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHand2() public {
        uint8 newExpansionId = type(uint8).max;
        uint16 newItemId = type(uint16).max;

        _setHand2(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _hand2(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    function testHand2Fuzz(uint8 newExpansionId, uint16 newItemId) public {
        _setHand2(1, newExpansionId, newItemId);
        (uint256 expansionId, uint256 itemId) = _hand2(1);

        assertEq(expansionId, newExpansionId);
        assertEq(itemId, newItemId);
    }

    // INTERNALS
    function _background(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.background(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("background, gas usage:", gasUsage);
    }

    function _setBackground(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 0, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setBackground(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setBackground, gas usage:", gasUsage);
    }

    function _head(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.head(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("head, gas usage:", gasUsage);
    }

    function _setHead(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 1, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setHead(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setHead, gas usage:", gasUsage);
    }

    function _chest(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.chest(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("chest, gas usage:", gasUsage);
    }

    function _setChest(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 2, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setChest(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setChest, gas usage:", gasUsage);
    }

    function _shoulders(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.shoulders(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("shoulders, gas usage:", gasUsage);
    }

    function _setShoulders(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 3, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setShoulders(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setShoulders, gas usage:", gasUsage);
    }

    function _back(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.back(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("back, gas usage:", gasUsage);
    }

    function _setBack(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 4, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setBack(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setBack, gas usage:", gasUsage);
    }

    function _accessories(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.accessories(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("accessories, gas usage:", gasUsage);
    }

    function _setAccessories(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 5, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setAccessories(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setAccessories, gas usage:", gasUsage);
    }

    function _hand1(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.hand1(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("hand1, gas usage:", gasUsage);
    }

    function _setHand1(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 6, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setHand1(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setHand1, gas usage:", gasUsage);
    }

    function _hand2(uint256 tokenId) internal view returns (uint256 expansionId, uint256 itemId) {
        uint256 gasUsage = gasleft();
        (expansionId, itemId) = shadows.hand2(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("hand2, gas usage:", gasUsage);
    }

    function _setHand2(uint256 tokenId, uint8 newExpansionId, uint16 newItemId) internal {
        vm.expectEmit(true, true, false, false);
        emit ExpansionSet(tokenId, 7, newExpansionId, newItemId);

        uint256 gasUsage = gasleft();
        shadows.setHand2(tokenId, newExpansionId, newItemId);
        gasUsage = gasUsage - gasleft();
        console.log("setHand2, gas usage:", gasUsage);
    }

    function _seed(uint256 tokenId) internal view returns (uint256 seed) {
        uint256 gasUsage = gasleft();
        (seed) = shadows.seed(tokenId);
        gasUsage = gasUsage - gasleft();
        console.log("seed, gas usage:", gasUsage);
    }
}
