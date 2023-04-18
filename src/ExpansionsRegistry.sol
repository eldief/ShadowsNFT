// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@solady/auth/Ownable.sol";

/// @title ExpansionsRegistry
/// @author @eldief
/// @notice Contract for registering `Expansions` addresses
/// @dev Uses `Solady.Ownable` for ownership
contract ExpansionsRegistry is Ownable {
    /*
        ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐
        ├┤ └┐┌┘├┤ │││ │ └─┐
        └─┘ └┘ └─┘┘└┘ ┴ └─┘ */
    /// @notice `ExpansionSet` event
    event ExpansionSet(uint8 indexed expansionId, address expansion);

    /*
        ┌─┐┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐
        └─┐ │ │ │├┬┘├─┤│ ┬├┤ 
        └─┘ ┴ └─┘┴└─┴ ┴└─┘└─┘   */
    /// @notice Expansion addresses
    /// @dev Public mapping from `expansionId` to `expansion` address
    mapping(uint256 => address) public expansions;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┌─┐┬─┐
        │  │ ││││└─┐ │ ├┬┘│ ││   │ │ │├┬┘
        └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ └─┘┴└─   */
    /// @notice Constructor
    /// @dev Initialize ownership via `Solady.Ownable`
    constructor() {
        _initializeOwner(msg.sender);
    }

    /*
        ┬─┐┌─┐┌─┐┬┌─┐┌┬┐┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
        ├┬┘├┤ │ ┬│└─┐ │ ├┬┘├─┤ │ ││ ││││
        ┴└─└─┘└─┘┴└─┘ ┴ ┴└─┴ ┴ ┴ ┴└─┘┘└┘    */
    /// @notice Register an expansion
    /// @dev If `expansion` is `address(0)`, `expansionId` is unregistered
    ///      See `Solady.Ownable.onlyOwner` modifier for reverts`
    ///      Emit `ExpansionSet` event
    /// @param expansionId uint8 Expansion id
    /// @param expansion address Expansion address
    function registerExpansion(uint8 expansionId, address expansion) external onlyOwner {
        expansions[expansionId] = expansion;

        emit ExpansionSet(expansionId, expansion);
    }
}
