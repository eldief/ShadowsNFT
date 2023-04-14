// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IERC721Component {
    function attach(uint256 componentId, uint256 composableId) external;

    function detach(uint256 componentId) external;

    function image(uint256 componentId) external view returns (bytes memory);

    function attributes(uint256 componentId) external view returns (bytes memory);
}
