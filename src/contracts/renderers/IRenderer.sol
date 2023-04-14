
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


interface IRenderer {

    function image(bytes32 seed) external pure returns (bytes memory);
    
    function attributes(bytes32 seed) external pure returns (bytes memory);
}
