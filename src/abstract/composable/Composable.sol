// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IComposable} from "./IComposable.sol";

/**
 * @notice Abstract contract representing a composable entity.
 * @author @eldief
 */
abstract contract Composable is IComposable {
    /**
     * @notice Array of component addresses.
     */
    address[] internal _components;

    /**
     * @notice Link each composable token to it's components.
     * @dev composableId -> slotId -> componentId
     */
    mapping(uint256 => mapping(uint256 => uint256)) internal _attached;

    /**
     * @notice Expand component collections.
     * @notice Allowes to create future expansions for the composable token.
     * @dev Can only be called by contract owner.
     * @param component new component address
     */
    function expandComponents(address component) public virtual {
        require(component != address(0), "Invalid component");

        _components.push(component);
    }

    /**
     * @notice Get all component addresses.
     * @return component contract addresses
     */
    function componentAddresses() public view virtual returns (address[] memory) {
        return _components;
    }

    /**
     * @notice Internal function that attach a component to composable.
     * @dev Component slot must be initialized.
     * @dev Composable and component must be owned by caller.
     * @param composableId composable id
     * @param slotId component slot id
     * @param componentId component id
     */
    function _attachComponent(uint256 composableId, uint256 slotId, uint256 componentId) internal {
        require(_components[slotId] != address(0), "Invalid component slot");

        _attached[composableId][slotId] = componentId;
    }

    /**
     * @notice Internal function that detach all components from composable.
     * @dev Composable must be owned by caller.
     * @param composableId composable id
     */
    function _detachComponents(uint256 composableId) internal {
        for (uint8 slotId = 0; slotId < _components.length;) {
            uint256 componentId = attachedComponent(composableId, slotId);

            if (componentId != 0) {
                _detachComponent(composableId, slotId);
            }

            unchecked {
                ++slotId;
            }
        }
    }

    /**
     * @notice Internal function that detach a component from composable.
     * @dev Component slot must be initialized.
     * @dev Composable must be owned by caller.
     * @param composableId composable id
     * @param slotId component slot id
     */
    function _detachComponent(uint256 composableId, uint256 slotId) internal {
        require(_components[slotId] != address(0), "Invalid component slot");

        delete _attached[composableId][slotId];
    }

    /**
     * @notice Get all attached components ids.
     * @dev Returns 0 for empty component slots.
     * @param composableId composable id
     * @return components array of attached component ids
     */
    function attachedComponents(uint256 composableId) public view virtual returns (uint256[] memory) {
        uint256[] memory components = new uint256[](_components.length);

        for (uint8 slotId = 0; slotId < _components.length;) {
            components[slotId] = attachedComponent(composableId, slotId);
        }

        return components;
    }

    /**
     * @notice Get an attached components id.
     * @dev Returns 0 for empty component slot.
     * @param composableId composable id
     * @param slotId component slot id
     * @return component attached component id
     */
    function attachedComponent(uint256 composableId, uint256 slotId) public view virtual returns (uint256) {
        return _attached[composableId][slotId];
    }
}
