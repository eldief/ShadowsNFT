// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/*
        ┌─┐┌─┐┌┐┌┌┬┐┬─┐┌─┐┌─┐┌┬┐  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        │  │ ││││ │ ├┬┘├─┤│   │   │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
        └─┘└─┘┘└┘ ┴ ┴└─┴ ┴└─┘ ┴   └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘   */
/// @dev Reveal salt constants
uint256 constant REVEAL_SALT_MASK = 0xFFFFFFFFFFFFFFFF;

/// @dev Claim end constants
uint256 constant CLAIM_END_SLOT = 64;
uint256 constant CLAIM_END_MASK = 0xFFFFFFFFFFFFFFFF << 64;

/// @dev Royalties constants
uint256 constant ROYALTIES_SLOT = 128;
uint256 constant ROYALTIES_MASK = 0xFFFF << 128;

/// @dev Max quantity constants
uint256 constant MAX_QTY_SLOT = 144;
uint256 constant MAX_QTY_MASK = 0xFF << 144;

/// @dev Total max supply constants
uint256 constant MAX_TOTAL_SUPPLY_SLOT = 152;
uint256 constant MAX_TOTAL_SUPPLY_MASK = 0xFFFF << 152;

/// @dev Price gwei
uint256 constant PRICE_SLOT = 168;
uint256 constant PRICE_MASK = 0xFFFFFFFF << 168;

/*
       ┌┬┐┌─┐┬┌─┌─┐┌┐┌  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        │ │ │├┴┐├┤ │││  │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
        ┴ └─┘┴ ┴└─┘┘└┘  └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘     */
/// @dev Seed constants
uint256 constant SEED_MASK = 0xFFFFFFFFFFFFFFFF;

/// @dev Slot id constants
uint256 constant SLOT_ID_SLOT = 64;
uint256 constant SLOT_ID_MASK = 0xFF << 64;
