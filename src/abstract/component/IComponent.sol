// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IERC721A} from "@ERC721A/contracts/IERC721A.sol";

interface IComponent is IERC721A {
    function ID() external pure returns (uint8);
    function INFORMATION() external pure returns (uint256);
    function LEVEL() external pure returns (uint8);
}
