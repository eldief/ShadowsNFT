// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IComposable {
    function expandComponents(address component) external;

    function componentAddresses() external view returns (address[] memory);

    function attachedComponents(uint256 composableId) external view returns (uint256[] memory);

    function attachedComponent(uint256 composableId, uint256 slotId) external view returns (uint256);
}
