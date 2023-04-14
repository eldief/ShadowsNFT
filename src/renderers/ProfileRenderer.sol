// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IRenderer} from "./IRenderer.sol";

contract ProfileRenderer is IRenderer {
    function image(bytes32 seed) external pure returns (bytes memory) {
        return abi.encodePacked(_getRaceImage(seed));
    }

    function attributes(bytes32 seed) external pure returns (bytes memory) {
        return abi.encodePacked(
            "{" '"trait_type":"Profile Picture Race",' '"value":"',
            _getRaceValue(seed),
            '"' "}," "{" '"trait_type":"Profile Picture Gender",' '"value":"',
            _getGenderValue(seed),
            '"' "}"
        );
    }

    function _getRaceValue(bytes32 seed) private pure returns (bytes memory) {
        uint8 value = uint8(seed[0]);

        if (value % 16 == 0) {
            return bytes("Alien");
        } else if (value % 13 == 0) {
            return bytes("Robot");
        } else if (value % 8 == 0) {
            return bytes("Ape");
        } else {
            return bytes("Human");
        }
    }

    function _getRaceImage(bytes32 seed) private pure returns (string memory) {
        bytes memory value = _getRaceValue(seed);

        if (keccak256(value) == keccak256("Human")) {
            return "<g>" '<ellipse stroke="#000" ry="102" rx="71" id="svg_5" cy="228" cx="129" fill="#fff"/>'
            '<path d="m129,125c-21.8232,0 -39.5,-17.45304 -39.5,-39c0,-21.54696 17.6768,-39 39.5,-39c21.8232,0 39.5,17.45304 39.5,39c0,21.54696 -17.6768,39 -39.5,39z" opacity="undefined" stroke="#000" fill="#fff"/>'
            "</g>";
        } else {
            return "<g>" '<ellipse stroke="#000" ry="102" rx="71" id="svg_5" cy="228" cx="129" fill="#fff"/>'
            '<path stroke="#000" d="m129,127c-44.47514,0 -80.5,-17.45304 -80.5,-39c0,-21.54696 36.02486,-39 80.5,-39c44.47514,0 80.5,17.45304 80.5,39c0,21.54696 -36.02486,39 -80.5,39z" opacity="undefined" fill="#fff"/>'
            "</g>";
        }
    }

    function _getGenderValue(bytes32 seed) private pure returns (string memory) {
        uint8 value = uint8(seed[0]);

        if (value % 2 == 0) {
            return "Female";
        } else {
            return "Male";
        }
    }

    // function _getGenderRender(bytes32 seed) private pure returns (string memory) {
    //     string memory value = _getGenderValue(seed);

    // }
}
