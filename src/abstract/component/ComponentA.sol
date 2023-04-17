// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Component.sol";
import {LibBytes} from "../../utils/LibBytes.sol";

import {ERC721A} from "@ERC721A/contracts/ERC721A.sol";

contract ComponentA is Component, ERC721A {
    using LibBytes for uint256;

    // attributes (32)
    // | health | mana | armour | cost |

    // | race | helm | armour | shoulders | glasses | weapon | accessories |

    uint8 public constant ID = 1;
    uint256 private constant ID_SLOT = LibBytes.SLOT_0;

    uint8 public constant LEVEL = 1;
    uint256 private constant LEVEL_SLOT = LibBytes.SLOT_1;

    uint256 public constant INFORMATION = 1;

    constructor(string memory name, string memory symbol, address registry) Component(registry) ERC721A(name, symbol) {}

    function data(uint256 tokenId) external pure returns (uint256) {}
}
