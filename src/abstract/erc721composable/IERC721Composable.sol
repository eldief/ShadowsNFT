// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IERC721Composable {
    function attachComponent(uint256 composableId, uint256 slotId, uint256 componentId) external;

    function detachComponents(uint256 composableId) external;

    function detachComponent(uint256 composableId, uint256 slotId) external;
}
