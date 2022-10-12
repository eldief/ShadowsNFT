// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IRenderer} from './IRenderer.sol';

contract BackgroundRenderer is IRenderer {

    bytes16 private constant ALPHABET = '0123456789ABCDEF';

    function image(bytes32 seed) external pure returns (bytes memory) {
        return abi.encodePacked('<rect width="255" height="255" style="fill:#', _getColor(seed),'"/>');
    }

    function attributes(bytes32 seed) external pure returns (bytes memory) {
        return abi.encodePacked(
            '{'
                '"trait_type":"Background Color",'
                '"value":"#', _getColor(seed), '"'
            '}'
        );
    }

    function _getColor(bytes32 seed) private pure returns (bytes memory) {
        bytes memory buffer = new bytes(6);

        for (uint256 i = 0; i < 3; i++) {

            buffer[i * 2 + 1] = ALPHABET[uint8(seed[i]) & 0xf];
            buffer[i * 2] = ALPHABET[uint8(seed[i] >> 4) & 0xf];
        }

        return buffer;
    }
}
