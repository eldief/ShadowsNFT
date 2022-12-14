// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

import {Component} from '../component/Component.sol';
import {IERC721Component} from './IERC721Component.sol';

/**
* @notice Abstract contract representing a component NFT.
* @author @eldief
*/
abstract contract ERC721Component is IERC721Component, Component, ERC721 {

    constructor(string memory name, string memory symbol) ERC721(name, symbol) { }

    /**
     * @notice Attach component to it's composable.
     * @dev Component must be owned by caller.
     * @param componentId component id
     * @param composableId composable id
     */
    function attach(uint256 componentId, uint256 composableId) external virtual override {
        require(tx.origin == ownerOf(componentId), 'Not token owner');

        _attach(componentId, composableId);
    }

    /**
     * @notice Detach component from it's composable.
     * @dev Component must be owned by caller.
     * @param componentId component id
     */
    function detach(uint256 componentId) external virtual override {
        require(tx.origin == ownerOf(componentId), 'Not token owner');

        _detach(componentId);
    }

    /**
     * @dev Returns component on-chain render.
     * @dev Must be overridden in implementation contract.
     * @param componentId component id
     * @return component render
     */
    function image(uint256 componentId) public virtual view returns (bytes memory) { }
    
    /**
     * @dev Returns component on-chain attributes.
     * @dev Must be overridden in implementation contract.
     * @param componentId component id
     * @return component attributes metadata
     */
    function attributes(uint256 componentId) public virtual view returns (bytes memory) { }
}
