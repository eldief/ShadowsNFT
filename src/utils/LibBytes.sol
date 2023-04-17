// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library LibBytes {
    function value(uint256 packed, uint256 slot) internal pure returns (uint256) {
        return packed >> slot & BYTE_MASK;
    }

    uint256 internal constant BYTE_MASK = 0xFF;

    uint256 internal constant SLOT_0 = 0;
    uint256 internal constant SLOT_1 = 8;
    uint256 internal constant SLOT_2 = 16;
    uint256 internal constant SLOT_3 = 24;
    uint256 internal constant SLOT_4 = 32;
    uint256 internal constant SLOT_5 = 40;
    uint256 internal constant SLOT_6 = 48;
    uint256 internal constant SLOT_7 = 56;
    uint256 internal constant SLOT_8 = 64;
    uint256 internal constant SLOT_9 = 72;
    uint256 internal constant SLOT_10 = 80;
    uint256 internal constant SLOT_11 = 88;
    uint256 internal constant SLOT_12 = 96;
    uint256 internal constant SLOT_13 = 104;
    uint256 internal constant SLOT_14 = 112;
    uint256 internal constant SLOT_15 = 120;
    uint256 internal constant SLOT_16 = 128;
    uint256 internal constant SLOT_17 = 136;
    uint256 internal constant SLOT_18 = 144;
    uint256 internal constant SLOT_19 = 152;
    uint256 internal constant SLOT_20 = 160;
    uint256 internal constant SLOT_21 = 168;
    uint256 internal constant SLOT_22 = 176;
    uint256 internal constant SLOT_23 = 184;
    uint256 internal constant SLOT_24 = 192;
    uint256 internal constant SLOT_25 = 200;
    uint256 internal constant SLOT_26 = 208;
    uint256 internal constant SLOT_27 = 216;
    uint256 internal constant SLOT_28 = 224;
    uint256 internal constant SLOT_29 = 232;
    uint256 internal constant SLOT_30 = 240;
    uint256 internal constant SLOT_31 = 248;
}
