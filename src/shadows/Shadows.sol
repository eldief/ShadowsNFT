// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// import {Base64} from '@openzeppelin/contracts/utils/Base64.sol';
// import {Strings} from '@openzeppelin/contracts/utils/Strings.sol';
// import {Counters} from '@openzeppelin/contracts/utils/Counters.sol';

import {ERC721Component} from "../abstract/erc721component/ERC721Component.sol";
import {ERC721Composable} from "../abstract/erc721composable/ERC721Composable.sol";

contract Shadows is ERC721Composable {
    // using Strings for uint256;
    // using Counters for Counters.Counter;

    address private _owner;

    // uint16 public constant CAP = 10_000;

    // string public constant BASE_URI = 'todo/render/shadow/';

    // Counters.Counter private _counter;

    constructor() ERC721Composable("Shadows", "SHDW") {
        _owner = msg.sender;
    }

    // function mint() public {
    //     require (_counter.current() < CAP, 'Minted out');

    //     _counter.increment();
    //     uint256 composableId = _counter.current();

    //     _safeMint(msg.sender, composableId);
    // }

    // function tokenURI(uint256 composableId) public view override returns (string memory) {
    //     require (_exists(composableId), 'Invalid token id');

    //     bytes memory data = abi.encodePacked(
    //         'data:application/json;base64,',
    //         Base64.encode(
    //             abi.encodePacked(
    //                 '{'
    //                     '"name":"Shadow #', composableId.toString(),'",',
    //                     '"description":"Shadows composable NFT",',
    //                     '"external_url":"', BASE_URI, composableId.toString(), '",',
    //                     '"attributes":[', _attributes(composableId), '],'
    //                     '"image":"data:image/svg+xml;base64,', Base64.encode(abi.encodePacked(
    //                         '<svg width="255" height="255" xmlns="http://www.w3.org/2000/svg">',
    //                         _image(composableId),
    //                         '</svg>'
    //                     )), '"'
    //                 '}'
    //             )
    //         )
    //     );

    //     return string(data);
    // }

    // function _image(uint256 composableId) private view returns (bytes memory) {
    //     bytes memory data;
    //     address[] memory comps = componentAddresses();

    //     for (uint8 slotId = 0; slotId < comps.length;) {

    //         uint256 componentId = attachedComponent(composableId, slotId);
    //         if (componentId != 0) {
    //             data = abi.encodePacked(data, ERC721Component(comps[slotId]).image(componentId));
    //         }

    //         unchecked {
    //             ++slotId;
    //         }
    //     }

    //     return data;
    // }

    // function _attributes(uint256 composableId) private view returns (bytes memory) {
    //     bytes memory data;
    //     address[] memory comps = componentAddresses();

    //     for (uint8 slotId = 0; slotId < comps.length;) {

    //         uint256 componentId = attachedComponent(composableId, slotId);
    //         if (componentId != 0) {

    //             data = abi.encodePacked(data, ERC721Component(comps[slotId]).attributes(componentId));

    //             if (slotId < comps.length - 1) {
    //                 data = abi.encodePacked(data, ',');
    //             }
    //         }

    //         unchecked {
    //             ++slotId;
    //         }
    //     }

    //     return data;
    // }

    // function transferFrom(address from, address to, uint256 composableId) public override  {
    //     require (_isApprovedOrOwner(_msgSender(), composableId), 'Not owner or approved');

    //     _transfer(from, to, composableId);

    //     // TODO - transfer components
    // }

    // function safeTransferFrom(address from, address to, uint256 composableId) public override {
    //     safeTransferFrom(from, to, composableId, '');
    // }

    // function safeTransferFrom(address from, address to, uint256 composableId, bytes memory data) public override {
    //     require (_isApprovedOrOwner(_msgSender(), composableId), 'Not owner or approved');

    //     _safeTransfer(from, to, composableId, data);

    //     // TODO - transfer components
    // }
}
