// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title IExpansionRenderer
/// @author @eldief
/// @notice Minimal importable interface for `ShadowsRenderer`
/// @dev Define `render` function, needed for rendering expansion equipments
interface IExpansionRenderer {
    function render(uint256 itemId)
        external
        view
        returns (uint256 slotId, bytes memory attributes, bytes memory image);
}
