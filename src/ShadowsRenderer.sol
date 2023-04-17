// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";

import "./ExpansionsRegistry.sol";
import "./libraries/EquipmentLib.sol";
import {IERC721A} from "@ERC721A/contracts/IERC721A.sol";
import {LibString} from "@solady/utils/LibString.sol";
import {DynamicBufferLib} from "@solady/utils/DynamicBufferLib.sol";

contract ShadowsRenderer {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

    struct RenderResult {
        bytes attributes;
        bytes image;
    }

    bytes internal constant _DESCRIPTION = "";

    /// @notice `ExpansionsRegistry` immutable contract reference
    ExpansionsRegistry public immutable registry;

    /// @notice Constructor
    /// @dev Register `ExpansionsRegistry` immutable reference
    constructor(address _registry) {
        registry = ExpansionsRegistry(_registry);
    }

    function render(address tokenOwner, uint256 tokenId, uint256 equipment) external view returns (string memory) {
        DynamicBufferLib.DynamicBuffer memory attributesBuffer;
        DynamicBufferLib.DynamicBuffer memory imageBuffer;

        _renderBase(attributesBuffer, imageBuffer, equipment);
        _renderExpansions(attributesBuffer, imageBuffer, tokenOwner, equipment);

        DynamicBufferLib.DynamicBuffer memory resultBuffer = DynamicBufferLib.DynamicBuffer("data:application/json,{");

        resultBuffer.append('"name":"Shadows #', LibString.toString(tokenId), '",');
        resultBuffer.append('"description":"', _DESCRIPTION, '",');
        resultBuffer.append('"image":"', imageBuffer.data, '",');
        resultBuffer.append('"attributes":"', attributesBuffer.data, '"}');

        return string(resultBuffer.data);
    }

    function _renderExpansions(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        address tokenOwner,
        uint256 equipment
    ) internal view {
        uint256 expansionId;
        uint256 itemId;

        {
            (expansionId, itemId) = EquipmentLib._background(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._head(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._chest(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._shoulders(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._back(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._accessories(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._hand1(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
        {
            (expansionId, itemId) = EquipmentLib._hand2(equipment);
            _renderExpansion(attributesBuffer, imageBuffer, tokenOwner, expansionId, itemId);
        }
    }

    function _renderExpansion(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        address tokenOwner,
        uint256 expansionId,
        uint256 itemId
    ) internal view {
        address expansion = registry.expansions(expansionId);
        if (tokenOwner == IERC721A(expansion).ownerOf(itemId)) return;

        (bytes memory attributes, bytes memory image) = IExpansionRender(expansion).render(itemId);
        
        attributesBuffer.append(attributes);
        imageBuffer.append(image);
    }
}
