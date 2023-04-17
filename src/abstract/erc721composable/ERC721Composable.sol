// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.9;

// import {ERC721A} from "@ERC721A/contracts/ERC721A.sol";

// import {Composable} from "../composable/Composable.sol";
// import {IERC721Composable} from "./IERC721Composable.sol";
// import {ERC721Component} from "../erc721component/ERC721Component.sol";

// /**
//  * @notice Abstract contract representing a composable NFT.
//  * @author @eldief
//  */
// abstract contract ERC721Composable is IERC721Composable, Composable, ERC721A {
//     constructor(string memory name, string memory symbol) ERC721A(name, symbol) {}

//     /**
//      * @notice Attach component to composable.
//      * @dev Component slot must be initialized.
//      * @dev Composable and component must be owned by caller.
//      * @param composableId composable id
//      * @param slotId component slot id
//      * @param componentId component id
//      */
//     function attachComponent(uint256 composableId, uint256 slotId, uint256 componentId) external virtual override {
//         require(ownerOf(composableId) == msg.sender, "Not composable owner");
//         require(ERC721Component(_components[slotId]).ownerOf(componentId) == msg.sender, "Not component owner");

//         _attachComponent(composableId, slotId, componentId);

//         ERC721Component(_components[slotId]).attach(componentId, composableId);
//     }

//     /**
//      * @notice Detach all components.
//      * @dev Component slot must be initialized.
//      * @dev Composable must be owned by caller.
//      * @param composableId composable id
//      */
//     function detachComponents(uint256 composableId) external virtual override {
//         require(ownerOf(composableId) == msg.sender, "Not composable owner");

//         for (uint8 slotId = 0; slotId < _components.length;) {
//             uint256 componentId = attachedComponent(composableId, slotId);

//             if (componentId != 0) {
//                 _detachComponent(composableId, slotId);

//                 ERC721Component(_components[slotId]).detach(_attached[composableId][slotId]);
//             }

//             unchecked {
//                 ++slotId;
//             }
//         }
//     }

//     /**
//      * @notice Detach component from composable.
//      * @dev Component slot must be initialized.
//      * @dev Composable must be owned by caller.
//      * @param composableId composable id
//      * @param slotId component slot id
//      */
//     function detachComponent(uint256 composableId, uint256 slotId) external virtual override {
//         require(ownerOf(composableId) == msg.sender, "Not composable owner");

//         _detachComponent(composableId, slotId);

//         ERC721Component(_components[slotId]).detach(_attached[composableId][slotId]);
//     }
// }
