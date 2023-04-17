// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IERC721A} from "@ERC721A/contracts/IERC721A.sol";

interface IComposable is IERC721A {
    function expandComponents(address component) external;

    function componentAddresses() external view returns (address[] memory);

    function attachedComponents(uint256 composableId) external view returns (uint256[] memory);

    function attachedComponent(uint256 composableId, uint256 slotId) external view returns (uint256);
}
