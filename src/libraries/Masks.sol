// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/// @dev Background constants
uint256 constant BACKGROUND_SLOT_ID = 0;
uint256 constant BACKGROUND_EXPANSION_ID_MASK = 0xFF;
uint256 constant BACKGROUND_ITEM_ID_SLOT = 8;
uint256 constant BACKGROUND_ITEM_ID_MASK = 0xFFFF << 8;

/// @dev Head constants
uint256 constant HEAD_SLOT_ID = 1;
uint256 constant HEAD_EXPANSION_ID_SLOT = 24;
uint256 constant HEAD_EXPANSION_ID_MASK = 0xFF << 24;
uint256 constant HEAD_ITEM_ID_SLOT = 32;
uint256 constant HEAD_ITEM_ID_MASK = 0xFFFF << 32;

/// @dev Chest constants
uint256 constant CHEST_SLOT_ID = 2;
uint256 constant CHEST_EXPANSION_ID_SLOT = 48;
uint256 constant CHEST_EXPANSION_ID_MASK = 0xFF << 48;
uint256 constant CHEST_ITEM_ID_SLOT = 56;
uint256 constant CHEST_ITEM_ID_MASK = 0xFFFF << 56;

/// @dev Shoulders constants
uint256 constant SHOULDERS_SLOT_ID = 3;
uint256 constant SHOULDERS_EXPANSION_ID_SLOT = 72;
uint256 constant SHOULDERS_EXPANSION_ID_MASK = 0xFF << 72;
uint256 constant SHOULDERS_ITEM_ID_SLOT = 80;
uint256 constant SHOULDERS_ITEM_ID_MASK = 0xFFFF << 80;

/// @dev Back constants
uint256 constant BACK_SLOT_ID = 4;
uint256 constant BACK_EXPANSION_ID_SLOT = 96;
uint256 constant BACK_EXPANSION_ID_MASK = 0xFF << 96;
uint256 constant BACK_ITEM_ID_SLOT = 104;
uint256 constant BACK_ITEM_ID_MASK = 0xFFFF << 104;

/// @dev Accessories constants
uint256 constant ACCESSORIES_SLOT_ID = 5;
uint256 constant ACCESSORIES_EXPANSION_ID_SLOT = 120;
uint256 constant ACCESSORIES_EXPANSION_ID_MASK = 0xFF << 120;
uint256 constant ACCESSORIES_ITEM_ID_SLOT = 128;
uint256 constant ACCESSORIES_ITEM_ID_MASK = 0xFFFF << 128;

/// @dev Hand 1 constants
uint256 constant HAND1_SLOT_ID = 6;
uint256 constant HAND1_EXPANSION_ID_SLOT = 144;
uint256 constant HAND1_EXPANSION_ID_MASK = 0xFF << 144;
uint256 constant HAND1_ITEM_ID_SLOT = 152;
uint256 constant HAND1_ITEM_ID_MASK = 0xFFFF << 152;

/// @dev Hand 2 constants
uint256 constant HAND2_SLOT_ID = 7;
uint256 constant HAND2_EXPANSION_ID_SLOT = 168;
uint256 constant HAND2_EXPANSION_ID_MASK = 0xFF << 168;
uint256 constant HAND2_ITEM_ID_SLOT = 176;
uint256 constant HAND2_ITEM_ID_MASK = 0xFFFF << 176;

/// @dev Seed constants
uint256 constant SEED_SLOT = 192;
