// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Masks.sol";

library EquipmentLib {
    /// @dev Internal function that returns expansion slot 0 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _background(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: packed & mask
            expansionId := and(equipment, BACKGROUND_EXPANSION_ID_MASK)
            // Get bits: (packed & mask) >> slot
            itemId := shr(BACKGROUND_ITEM_ID_SLOT, and(equipment, BACKGROUND_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 0 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packBackground(uint256 equipment, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(BACKGROUND_EXPANSION_ID_MASK, BACKGROUND_ITEM_ID_MASK)))
            // Write bits: packed | value
            equipment := or(equipment, expansionId)
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(BACKGROUND_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 1 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _head(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HEAD_EXPANSION_ID_SLOT, and(equipment, HEAD_EXPANSION_ID_MASK))
            itemId := shr(HEAD_ITEM_ID_SLOT, and(equipment, HEAD_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 1 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packHead(uint256 equipment, uint8 expansionId, uint16 itemId) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(HEAD_EXPANSION_ID_MASK, HEAD_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(HEAD_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(HEAD_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 2 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _chest(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(CHEST_EXPANSION_ID_SLOT, and(equipment, CHEST_EXPANSION_ID_MASK))
            itemId := shr(CHEST_ITEM_ID_SLOT, and(equipment, CHEST_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 2 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packChest(uint256 equipment, uint8 expansionId, uint16 itemId) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(CHEST_EXPANSION_ID_MASK, CHEST_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(CHEST_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(CHEST_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 3 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _shoulders(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(SHOULDERS_EXPANSION_ID_SLOT, and(equipment, SHOULDERS_EXPANSION_ID_MASK))
            itemId := shr(SHOULDERS_ITEM_ID_SLOT, and(equipment, SHOULDERS_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 3 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packShoulders(uint256 equipment, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(SHOULDERS_EXPANSION_ID_MASK, SHOULDERS_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(SHOULDERS_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(SHOULDERS_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 4 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _back(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(BACK_EXPANSION_ID_SLOT, and(equipment, BACK_EXPANSION_ID_MASK))
            itemId := shr(BACK_ITEM_ID_SLOT, and(equipment, BACK_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 4 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packBack(uint256 equipment, uint8 expansionId, uint16 itemId) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(BACK_EXPANSION_ID_MASK, BACK_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(BACK_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(BACK_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 5 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _accessories(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(ACCESSORIES_EXPANSION_ID_SLOT, and(equipment, ACCESSORIES_EXPANSION_ID_MASK))
            itemId := shr(ACCESSORIES_ITEM_ID_SLOT, and(equipment, ACCESSORIES_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 5 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packAccessories(uint256 equipment, uint8 expansionId, uint16 itemId)
        internal
        pure
        returns (uint256 result)
    {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(ACCESSORIES_EXPANSION_ID_MASK, ACCESSORIES_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(ACCESSORIES_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(ACCESSORIES_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 6 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _hand1(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HAND1_EXPANSION_ID_SLOT, and(equipment, HAND1_EXPANSION_ID_MASK))
            itemId := shr(HAND1_ITEM_ID_SLOT, and(equipment, HAND1_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 6 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packHand1(uint256 equipment, uint8 expansionId, uint16 itemId) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(HAND1_EXPANSION_ID_MASK, HAND1_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(HAND1_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(HAND1_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns expansion slot 7 data
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function _hand2(uint256 equipment) internal pure returns (uint256 expansionId, uint256 itemId) {
        assembly {
            // Get bits: (packed & mask) >> slot
            expansionId := shr(HAND2_EXPANSION_ID_SLOT, and(equipment, HAND2_EXPANSION_ID_MASK))
            itemId := shr(HAND2_ITEM_ID_SLOT, and(equipment, HAND2_ITEM_ID_MASK))
        }
    }

    /// @dev Internal function that set expansion slot 7 data
    ///      Pack `equipment` slot
    ///      Clear and override slot reserved bits
    /// @param equipment uint256 Packed `equipment` data
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    /// @return result uint256 Modified `equipment` param
    function _packHand2(uint256 equipment, uint8 expansionId, uint16 itemId) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~(mask1 | mask2)
            equipment := and(equipment, not(or(HAND2_EXPANSION_ID_MASK, HAND2_ITEM_ID_MASK)))
            // Write bits: packed | (value << slot)
            equipment := or(equipment, shl(HAND2_EXPANSION_ID_SLOT, expansionId))
            equipment := or(equipment, shl(HAND2_ITEM_ID_SLOT, itemId))
            result := equipment
        }
    }

    /// @dev Internal function that returns seed
    ///      Unpack `equipment` slots
    /// @param equipment uint256 Packed `equipment` data
    /// @return seed uint256 Unpacked `seed`
    function _seed(uint256 equipment) internal pure returns (uint256 seed) {
        assembly {
            // No need to mask since reading last packed bits
            // Get bits: packed >> slot
            seed := shr(SEED_SLOT, equipment)
        }
    }

    /// @dev Internal function that set 'seed'
    ///      Pack `seed` for `equipment` slot
    /// @param seed uint64 Seed
    /// @return equipment uint256 Initialized packed `equipment` param
    function _packSeed(uint64 seed) internal pure returns (uint256 equipment) {
        assembly {
            // No need to clear since
            // Write bits: value << slot
            equipment := shl(SEED_SLOT, seed)
        }
    }
}
