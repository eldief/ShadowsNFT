// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IComponent} from './IComponent.sol';

/**
* @notice Abstract contract representing a component entity.
* @author @eldief
*/
abstract contract Component is IComponent {
    
    /**
     * @notice Link each component to an attached composable.
     * @dev componentId -> composableId
     */
    mapping (uint256 => uint256) private _parents;

    /**
     * @notice Internal function that attach component to it's parent composable token id.
     * @dev Should be overridden to be called by component owner.
     * @param componentId component id
     * @param composableId composable id
     */
    function _attach(uint256 componentId, uint256 composableId) internal virtual {
        _parents[componentId] = composableId;
    }

    /**
     * @notice Internal function that detach component from it's parent composable token id.
     * @dev Should be overridden to be called by component owner.
     * @param componentId component id
     */
    function _detach(uint256 componentId) internal virtual {
        delete _parents[componentId];
    }
}