// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./ShadowsMasks.sol";

/// @title ShadowsLib
/// @author @eldief
/// @notice Library to pack / unpack `Shadows._tokenConfiguration`
/// @dev Import constants from `ShadowsMasks` library
library ShadowsLib {
    /*
       ┌┬┐┌─┐┬┌─┌─┐┌┐┌  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        │ │ │├┴┐├┤ │││  │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
        ┴ └─┘┴ ┴└─┘┘└┘  └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘     */
    /// @dev Internal function that returns expansion slot 0 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackBackground(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: packed & mask
            expansionId := and(tokenConfiguration, BACKGROUND_EXPANSION_ID_MASK)
            // Get bits: (packed & mask) >> slot
            itemId := shr(BACKGROUND_ITEM_ID_SLOT, and(tokenConfiguration, BACKGROUND_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 0 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packBackground(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration :=
                and(tokenConfiguration, not(or(BACKGROUND_EXPANSION_ID_MASK, BACKGROUND_ITEM_ID_MASK)))
            // Write bits: packed | value
            tokenConfiguration := or(tokenConfiguration, expansionId)
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(BACKGROUND_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 1 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackHead(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HEAD_EXPANSION_ID_SLOT, and(tokenConfiguration, HEAD_EXPANSION_ID_MASK))
            itemId := shr(HEAD_ITEM_ID_SLOT, and(tokenConfiguration, HEAD_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 1 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packHead(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(HEAD_EXPANSION_ID_MASK, HEAD_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(HEAD_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(HEAD_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 2 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackChest(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(CHEST_EXPANSION_ID_SLOT, and(tokenConfiguration, CHEST_EXPANSION_ID_MASK))
            itemId := shr(CHEST_ITEM_ID_SLOT, and(tokenConfiguration, CHEST_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 2 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packChest(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(CHEST_EXPANSION_ID_MASK, CHEST_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(CHEST_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(CHEST_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 3 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackShoulders(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(SHOULDERS_EXPANSION_ID_SLOT, and(tokenConfiguration, SHOULDERS_EXPANSION_ID_MASK))
            itemId := shr(SHOULDERS_ITEM_ID_SLOT, and(tokenConfiguration, SHOULDERS_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 3 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packShoulders(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(SHOULDERS_EXPANSION_ID_MASK, SHOULDERS_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(SHOULDERS_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(SHOULDERS_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 4 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackBack(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(BACK_EXPANSION_ID_SLOT, and(tokenConfiguration, BACK_EXPANSION_ID_MASK))
            itemId := shr(BACK_ITEM_ID_SLOT, and(tokenConfiguration, BACK_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 4 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packBack(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(BACK_EXPANSION_ID_MASK, BACK_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(BACK_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(BACK_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 5 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackAccessories(uint256 tokenConfiguration)
        internal
        pure
        returns (uint256 expansionId, uint256 itemId)
    {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(ACCESSORIES_EXPANSION_ID_SLOT, and(tokenConfiguration, ACCESSORIES_EXPANSION_ID_MASK))
            itemId := shr(ACCESSORIES_ITEM_ID_SLOT, and(tokenConfiguration, ACCESSORIES_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 5 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packAccessories(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration :=
                and(tokenConfiguration, not(or(ACCESSORIES_EXPANSION_ID_MASK, ACCESSORIES_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(ACCESSORIES_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(ACCESSORIES_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 6 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackHand1(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HAND1_EXPANSION_ID_SLOT, and(tokenConfiguration, HAND1_EXPANSION_ID_MASK))
            itemId := shr(HAND1_ITEM_ID_SLOT, and(tokenConfiguration, HAND1_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 6 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packHand1(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(HAND1_EXPANSION_ID_MASK, HAND1_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(HAND1_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(HAND1_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns expansion slot 7 data
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function unpackHand2(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HAND2_EXPANSION_ID_SLOT, and(tokenConfiguration, HAND2_EXPANSION_ID_MASK))
            itemId := shr(HAND2_ITEM_ID_SLOT, and(tokenConfiguration, HAND2_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 7 data
    ///      Pack `tokenConfiguration` slot
    ///      Clear and override slot reserved bits
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `tokenConfiguration` param
    function packHand2(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            tokenConfiguration := and(tokenConfiguration, not(or(HAND2_EXPANSION_ID_MASK, HAND2_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            tokenConfiguration := or(tokenConfiguration, shl(HAND2_EXPANSION_ID_SLOT, expansionId))
            tokenConfiguration := or(tokenConfiguration, shl(HAND2_ITEM_ID_SLOT, itemId))
            result := tokenConfiguration
        }
    }

    /// @dev Internal function that returns seed
    ///      Unpack `tokenConfiguration` slots
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return seed uint256 Unpacked `seed`
    function unpackSeed(uint256 tokenConfiguration) internal pure returns (uint256 seed) {
        assembly {
            // No need to mask since reading last packed bits
            // Get bits: packed >> slot
            seed := shr(SEED_SLOT, tokenConfiguration)
        }
    }

    /// @dev Internal function that set 'seed'
    ///      Pack `seed` for `tokenConfiguration` slot
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param seed uint64 Seed
    /// @return result uint256 Modified `tokenConfiguration` param
    function packSeed(uint256 tokenConfiguration, uint64 seed) internal pure returns (uint256 result) {
        assembly {
            // No need to clear since
            // Write bits: value << slot
            tokenConfiguration := shl(SEED_SLOT, seed)
            result := tokenConfiguration
        }
    }
}
