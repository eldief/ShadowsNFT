// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./ExpansionBase.sol";

/*
  ██████  ██░ ██  ▄▄▄      ▓█████▄  ▒█████   █     █░  ██████ 
▒██    ▒ ▓██░ ██▒▒████▄    ▒██▀ ██▌▒██▒  ██▒▓█░ █ ░█░▒██    ▒ 
░ ▓██▄   ▒██▀▀██░▒██  ▀█▄  ░██   █▌▒██░  ██▒▒█░ █ ░█ ░ ▓██▄   
  ▒   ██▒░▓█ ░██ ░██▄▄▄▄██ ░▓█▄   ▌▒██   ██░░█░ █ ░█   ▒   ██▒
▒██████▒▒░▓█▒░██▓ ▓█   ▓██▒░▒████▓ ░ ████▓▒░░░██▒██▓ ▒██████▒▒
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▓░▒ ▒  ▒ ▒▓▒ ▒ ░
░ ░▒  ░ ░ ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ▒  ▒   ░ ▒ ▒░   ▒ ░ ░  ░ ░▒  ░ ░
░  ░  ░   ░  ░░ ░  ░   ▒    ░ ░  ░ ░ ░ ░ ▒    ░   ░  ░  ░  ░  
      ░   ░  ░  ░      ░  ░   ░        ░ ░      ░          ░  
    ╔╗ ╔═╗╔═╗╔═╗  ╔═╗═╗ ╦╔═╗╔═╗╔╗╔╔═╗╦╔═╗╔╗╔  ╔═╗╔═╗╔═╗╦╔═
    ╠╩╗╠═╣╚═╗║╣   ║╣ ╔╩╦╝╠═╝╠═╣║║║╚═╗║║ ║║║║  ╠═╝╠═╣║  ╠╩╗
    ╚═╝╩ ╩╚═╝╚═╝  ╚═╝╩ ╚═╩  ╩ ╩╝╚╝╚═╝╩╚═╝╝╚╝  ╩  ╩ ╩╚═╝╩ ╩  */

/// @title Shadows - Base Expansion Pack
/// @author @eldief
/// @notice Shadows NFT first expansion pack
/// @dev Inherit shared functionalities from `ExpansionBase`
///      Customize configuration and rendering
contract BaseExpansionPack is ExpansionBase {
    using LibString for uint256;
    using ExpansionsLib for uint256;
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┌─┐┬─┐
        │  │ ││││└─┐ │ ├┬┘│ ││   │ │ │├┬┘
        └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ └─┘┴└─   */
    /// @notice Constructor
    /// @dev Initialize `configuration` packing data
    ///      See `ExpansionBase.constructor` for nested initialization
    ///      See `ExpansionBase._configuration` for packed layout
    ///      See `ExpansionsLib` for pack information
    constructor(address shadows_) ExpansionBase(shadows_, "Shadows - Base Expansion Pack", "SHDWS_BASE_EXP") {
        uint256 configuration;
        {
            configuration = configuration.packClaimEnd(uint64(block.timestamp + 7 days));
            configuration = configuration.packRoyalties(500);
            configuration = configuration.packMaxQuantity(2);
            configuration = configuration.packMaxTotalSupply(10_000);
            configuration = configuration.packPrice(0.01 ether / 1 gwei);
        }
        _configuration = configuration;
    }

    /*
        ┬─┐┌─┐┌┐┌┌┬┐┌─┐┬─┐┬┌┐┌┌─┐  ┌─┐┬  ┬┌─┐┬─┐┬─┐┬┌┬┐┌─┐┌─┐
        ├┬┘├┤ │││ ││├┤ ├┬┘│││││ ┬  │ │└┐┌┘├┤ ├┬┘├┬┘│ ││├┤ └─┐
        ┴└─└─┘┘└┘─┴┘└─┘┴└─┴┘└┘└─┘  └─┘ └┘ └─┘┴└─┴└─┴─┴┘└─┘└─┘   */
    /// @notice Render unrevealed `Shadows - Base Expansion Pack` token
    /// @dev See `ExpansionBase._renderUnrevealed`
    function _renderUnrevealed(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        uint256 seed,
        uint256 tokenId
    ) internal view override returns (uint256) {
        // WIP
        attributesBuffer.append('{"trait_type":"seed","value":"', bytes(seed.toString()), '"},');
        attributesBuffer.append('{"trait_type":"tokenId","value":"', bytes(tokenId.toString()), '"}');
        imageBuffer.append("__UNREVELEADED_IMAGE__");
        return 0;
    }

    /// @notice Render revealed `Shadows - Base Expansion Pack` token
    /// @dev See `ExpansionBase._renderRevealed`
    function _renderRevealed(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        uint256 seed,
        uint256 tokenId
    ) internal view override returns (uint256 slotId) {
        // WIP
        attributesBuffer.append('{"trait_type":"seed","value":"', bytes(seed.toString()), '"},');
        attributesBuffer.append('{"trait_type":"tokenId","value":"', bytes(tokenId.toString()), '"}');
        imageBuffer.append(bytes("__REVEALED_IMAGE__"));
        slotId = 1;
    }
}
