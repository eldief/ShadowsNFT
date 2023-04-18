// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import "./ExpansionsRegistry.sol";
import "./libraries/ShadowsLib.sol";
import "./interfaces/IExpansionRenderer.sol";
import "@solady/utils/LibString.sol";
import "@solady/utils/DynamicBufferLib.sol";
import "@ERC721A/contracts/IERC721A.sol";

/// @title ShadowsRenderer
/// @author @eldief
/// @notice Renderer contact for `Shadows`
/// @dev Uses `Solady.LibString` for string manipulation
///      Uses `ShadowsLib` for packing / unpacking
///      Uses `Solady.DynamicBufferLib` for bytes concatenation
contract ShadowsRenderer {
    using LibString for uint256;
    using ShadowsLib for uint256;
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐   ┬┌┬┐┌┬┐┬ ┬┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐
        │  │ ││││└─┐ │ ───││││││││ │ │ ├─┤├┴┐│  ├┤ └─┐
        └─┘└─┘┘└┘└─┘ ┴    ┴┴ ┴┴ ┴└─┘ ┴ ┴ ┴└─┘┴─┘└─┘└─┘  */
    /// @notice Constant contract `description`
    bytes internal constant _DESCRIPTION = "";

    /// @notice `ExpansionsRegistry` immutable contract reference
    ExpansionsRegistry public immutable registry;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┌─┐┬─┐
        │  │ ││││└─┐ │ ├┬┘│ ││   │ │ │├┬┘
        └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ └─┘┴└─   */
    /// @notice Constructor
    /// @dev Register `ExpansionsRegistry` immutable reference
    constructor(address _registry) {
        registry = ExpansionsRegistry(_registry);
    }

    /*
        ┬─┐┌─┐┌┐┌┌┬┐┌─┐┬─┐┬┌┐┌┌─┐
        ├┬┘├┤ │││ ││├┤ ├┬┘│││││ ┬
        ┴└─└─┘┘└┘─┴┘└─┘┴└─┴┘└┘└─┘   */
    /// @notice Render `Shadows.tokenURI`
    /// @dev On-chain render for `Shadows` NFT
    ///      Buffers are instanciated here and passed by reference to internal functions
    ///      Render both `Shadows` metadata and valid `Expansions` metadata
    /// @param tokenOwner address Rendering token owner
    /// @param tokenId uint256 Token id
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration`
    /// @return tokenURI On-chain svg Base64 encoded
    function render(address tokenOwner, uint256 tokenId, uint256 tokenConfiguration)
        external
        view
        returns (string memory tokenURI)
    {
        DynamicBufferLib.DynamicBuffer memory attributesBuffer;
        DynamicBufferLib.DynamicBuffer memory imageBuffer;

        _renderBase(attributesBuffer, imageBuffer, tokenConfiguration);
        _renderExpansions(attributesBuffer, imageBuffer, tokenOwner, tokenConfiguration);

        DynamicBufferLib.DynamicBuffer memory resultBuffer = DynamicBufferLib.DynamicBuffer("data:application/json,{");
        {
            resultBuffer.append('"name":"Shadows #', bytes(LibString.toString(tokenId)), '",');
            resultBuffer.append('"description":"', _DESCRIPTION, '",');
            resultBuffer.append('"image":"', imageBuffer.data, '",');
            resultBuffer.append('"attributes":[', attributesBuffer.data, "]}");
        }
        tokenURI = string(resultBuffer.data);
    }

    /// @notice Render `Shadows` metadata
    /// @dev Internal function that renders this token
    ///      Buffers are passed by reference to save gas while appending data
    /// @param attributesBuffer DynamicBufferLib.DynamicBuffer for attributes metadata
    /// @param imageBuffer DynamicBufferLib.DynamicBuffer for image metadata
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration`
    function _renderBase(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        uint256 tokenConfiguration
    ) internal view {
        uint256 seed = tokenConfiguration.unpackSeed();
        attributesBuffer.append('{"trait_type":"seed","value":"', bytes(seed.toString()), '"}');
        imageBuffer.append("__BASEIMAGE__");
    }

    /// @notice Render `Expansions` metadata
    /// @dev Internal function that renders each equipment slot
    ///      Buffers are passed by reference to save gas while appending data
    /// @param attributesBuffer DynamicBufferLib.DynamicBuffer for attributes metadata
    /// @param imageBuffer DynamicBufferLib.DynamicBuffer for image metadata
    /// @param tokenOwner address Rendering token owner
    /// @param tokenConfiguration uint256 Packed `tokenConfiguration`
    function _renderExpansions(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        address tokenOwner,
        uint256 tokenConfiguration
    ) internal view {
        uint256 expansionId;
        uint256 itemId;
        {
            (expansionId, itemId) = tokenConfiguration.unpackBackground();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, BACKGROUND_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackHead();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, HEAD_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackChest();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, CHEST_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackShoulders();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, SHOULDERS_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackBack();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, BACK_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackAccessories();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, ACCESSORIES_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackHand1();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, HAND1_SLOT_ID);
        }
        {
            (expansionId, itemId) = tokenConfiguration.unpackHand2();
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId, HAND2_SLOT_ID);
        }
    }

    /// @notice Render an `Expansion` metadata
    /// @dev Internal function that renders an equipment slot
    ///      Buffers are passed by reference to save gas while appending data
    ///      Checking equipment validity is delegated to this view function to save gas on setters
    ///      Because of this, a try-catch block is needed to prevent reverting `tokenURI` function
    ///      Read from `ExpansionsRegistry` the address link to `expansionId`
    ///      Skip rendering if expansion is invalid, equipment is not owned by `tokenOwner` or `slot` is invalid for `itemId`
    /// @param attributesBuffer DynamicBufferLib.DynamicBuffer for attributes metadata
    /// @param imageBuffer DynamicBufferLib.DynamicBuffer for image metadata
    /// @param tokenOwner address Owner of rendered tokenId
    /// @param expansionId uint256 Expansion id
    /// @param itemId uint256 Item id
    /// @param slotId uint256 Slot id
    function _renderExpansion(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        address tokenOwner,
        uint256 expansionId,
        uint256 itemId,
        uint256 slotId
    ) internal view {
        // Using multi-line comments to prevent forge-fmt to produce less readable code
        address expansion = registry.expansions(expansionId);
        /*
            Check if expansion is registered
        */
        if (expansion != address(0)) {
            /*
                Add try-catch block since having no check on setting equipment
                could make this function revert when itemId is invalid
            */
            try IERC721A(expansion).ownerOf(itemId) returns (address itemOwner) {
                /*
                    Check if expansion item id is owner by the same Shadow owner
                */
                if (tokenOwner == itemOwner) {
                    (uint256 expansionSlotId, bytes memory attributes, bytes memory image) =
                        IExpansionRenderer(expansion).render(itemId);
                    /*
                        Check if item id is for the correct slot
                    */
                    if (slotId == expansionSlotId) {
                        attributesBuffer.append(',{"trait_type":"Slot id ', bytes(slotId.toString()), '",');
                        attributesBuffer.append('"value":[', attributes, "]}");
                        imageBuffer.append(image);

                        return;
                    }
                }
            } catch {
                // Pass
            }
        }
        // If any condition is false, append "None" to equipment trait
        attributesBuffer.append(',{"trait_type":"Slot id ', bytes(slotId.toString()), '","value":"None"}');
    }
}
