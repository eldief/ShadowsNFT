// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ExpansionsRegistry {
    /// @notice `NotOwner` error
    error NotOwner();

    /// @notice `ExpansionSet` event
    event ExpansionSet(uint8 indexed expansionId, address expansion);

    /// @notice Contract owner
    address public immutable owner;

    /// @notice Expansion addresses
    /// @dev Public mapping from `expansionId` to `expansion` address
    mapping(uint256 => address) public expansions;

    /// @notice Constructor
    /// @dev Set immutable contract `owner`
    constructor() {
        owner = msg.sender;
    }

    /// @notice Register an expansion
    /// @dev If `expansion` is `address(0)`, `expansionId` is unregistered
    ///      Reverts with `NoOwner` when not called by `owner`
    ///      Emit `ExpansionSet` event
    /// @param expansionId uint8 Expansion id
    /// @param expansion address Expansion address
    function registerExpansion(uint8 expansionId, address expansion) external {
        if (msg.sender != owner) revert NotOwner();
        expansions[expansionId] = expansion;

        emit ExpansionSet(expansionId, expansion);
    }
}
