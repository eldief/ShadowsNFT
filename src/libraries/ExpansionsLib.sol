// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./ExpansionsMasks.sol";

/// @title ExpansionsLib
/// @author @eldief
/// @notice Library to pack / unpack `ExpansionBase._configuration` and `ExpansionBase._tokenConfiguration`
/// @dev Import constants from `ExpansionMasks` library
library ExpansionsLib {
    /*
        ┌─┐─┐ ┬┌─┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        ├┤ ┌┴┬┘├─┘├─┤│││└─┐││ ││││  │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
        └─┘┴ └─┴  ┴ ┴┘└┘└─┘┴└─┘┘└┘  └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘ */
    /// @dev Internal function that returns `salt`
    ///      Unpack `salt` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `salt`
    function unpackSalt(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: packed & mask
            value := and(configuration, REVEAL_SALT_MASK)
        }
    }

    /// @dev Internal function that set `salt`
    ///      Pack `configuration` slot
    ///      Do not clear slot since `salt` can only be set once
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint64 Salt
    /// @return result uint256 Modified `configuration` param
    function packSalt(uint256 configuration, uint64 value) internal pure returns (uint256 result) {
        assembly {
            // Write bits: packed | value
            configuration := or(configuration, value)
            result := configuration
        }
    }

    /// @dev Internal function that returns `claim end`
    ///      Unpack `claim end` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `claim end`
    function unpackClaimEnd(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: (packed & mask) >> slot
            value := shr(CLAIM_END_SLOT, and(configuration, CLAIM_END_MASK))
        }
    }

    /// @dev Internal function that set `claim end`
    ///      Pack `configuration` slot
    ///      Clear and override slot reserved bits
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint64 Claim end
    /// @return result uint256 Modified `configuration` param
    function packClaimEnd(uint256 configuration, uint64 value) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~mask
            configuration := and(configuration, not(CLAIM_END_MASK))
            // Write bits: packed | (value << slot)
            configuration := or(configuration, shl(CLAIM_END_SLOT, value))
            result := configuration
        }
    }

    /// @dev Internal function that returns `royalties`
    ///      Unpack `royalties` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `royalties`
    function unpackRoyalties(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: (packed & mask) >> slot
            value := shr(ROYALTIES_SLOT, and(configuration, ROYALTIES_MASK))
        }
    }

    /// @dev Internal function that set `royalties`
    ///      Pack `configuration` slot
    ///      Clear and override slot reserved bits
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint16 Royalties in BPs
    /// @return result uint256 Modified `configuration` param
    function packRoyalties(uint256 configuration, uint16 value) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~mask
            configuration := and(configuration, not(ROYALTIES_MASK))
            // Write bits: packed | (value << slot)
            configuration := or(configuration, shl(ROYALTIES_SLOT, value))
            result := configuration
        }
    }

    /// @dev Internal function that returns `max quantity`
    ///      Unpack `max quantity` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `max quantity`
    function unpackMaxQuantity(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: (packed & mask) >> slot
            value := shr(MAX_QTY_SLOT, and(configuration, MAX_QTY_MASK))
        }
    }

    /// @dev Internal function that set `max quantity`
    ///      Pack `configuration` slot
    ///      Clear and override slot reserved bits
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint8 Max quantity
    /// @return result uint256 Modified `configuration` param
    function packMaxQuantity(uint256 configuration, uint8 value) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~mask
            configuration := and(configuration, not(MAX_QTY_MASK))
            // Write bits: packed | (value << slot)
            configuration := or(configuration, shl(MAX_QTY_SLOT, value))
            result := configuration
        }
    }

    /// @dev Internal function that returns `total supply`
    ///      Unpack `total supply` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `total supply`
    function unpackMaxTotalSupply(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: (packed & mask) >> slot
            value := shr(MAX_TOTAL_SUPPLY_SLOT, and(configuration, MAX_TOTAL_SUPPLY_MASK))
        }
    }

    /// @dev Internal function that set `maxTotalSupply`
    ///      Pack `configuration` slot
    ///      Clear and override slot reserved bits
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint16 Total max supply
    /// @return result uint256 Modified `configuration` param
    function packMaxTotalSupply(uint256 configuration, uint16 value) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~mask
            configuration := and(configuration, not(MAX_TOTAL_SUPPLY_MASK))
            // Write bits: packed | (value << slot)
            configuration := or(configuration, shl(MAX_TOTAL_SUPPLY_SLOT, value))
            result := configuration
        }
    }

    /// @dev Internal function that returns `price`
    ///      Unpack `price` from `configuration`
    /// @param configuration uint256 Packed `configuration` data
    /// @return value uint256 Unpacked `price`
    function unpackPrice(uint256 configuration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: (packed & mask) >> slot
            value := shr(PRICE_SLOT, and(configuration, PRICE_MASK))
        }
    }

    /// @dev Internal function that set `price`
    ///      Pack `configuration` slot
    ///      Clear and override slot reserved bits
    /// @param configuration uint256 Packed `configuration` data
    /// @param value uint32 Price in gwei
    /// @return result uint256 Modified `configuration` param
    function packPrice(uint256 configuration, uint32 value) internal pure returns (uint256 result) {
        assembly {
            // Clear bits: packed & ~mask
            configuration := and(configuration, not(PRICE_MASK))
            // Write bits: packed | (value << slot)
            configuration := or(configuration, shl(PRICE_SLOT, value))
            result := configuration
        }
    }

    /*
       ┌┬┐┌─┐┬┌─┌─┐┌┐┌  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        │ │ │├┴┐├┤ │││  │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
        ┴ └─┘┴ ┴└─┘┘└┘  └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘     */
    /// @dev Internal function that returns `seed`
    ///      Unpack `seed` from `tokenConfiguration`
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @return value uint256 Unpacked `seed`
    function unpackSeed(uint256 tokenConfiguration) internal pure returns (uint256 value) {
        assembly {
            // Get bits: packed & mask
            value := and(tokenConfiguration, SEED_MASK)
        }
    }

    /// @dev Internal function that set `seed`
    ///      Pack `tokenConfiguration` slot
    ///      Do not clear slot since `seed` can only be set once
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration` data
    /// @param value uint64 seed
    /// @return result uint256 Modified `tokenConfiguration` param
    function packSeed(uint256 tokenConfiguration, uint64 value) internal pure returns (uint256 result) {
        assembly {
            // Write bits: packed | value
            tokenConfiguration := or(tokenConfiguration, value)
            result := tokenConfiguration
        }
    }

    // ... TBD
}
