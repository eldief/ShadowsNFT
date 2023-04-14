// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Base64} from '@openzeppelin/contracts/utils/Base64.sol';
import {Strings} from '@openzeppelin/contracts/utils/Strings.sol';
import {Counters} from '@openzeppelin/contracts/utils/Counters.sol';

import {IRenderer} from '../renderers/IRenderer.sol';
import {ERC721Component} from '../abstract/erc721component/ERC721Component.sol';

contract ProfileComponent is ERC721Component {
    using Strings for uint256;
    using Counters for Counters.Counter;

    address private _owner;

    uint16 public constant CAP = 10_000;

    string public constant BASE_URI = 'todo/render/pfp/';

    mapping (uint256 => bytes32) private _seeds;
    
    Counters.Counter private _counter;

    IRenderer private immutable _renderer;

    constructor(address renderer) ERC721Component('Shadows Profile', 'SHDW_PFP') {
        _owner = msg.sender;
        _renderer = IRenderer(renderer);
    }

    function mint() public {
        require (_counter.current() < CAP, 'Minted out');

        _counter.increment();
        uint256 componentId = _counter.current();

        _seeds[componentId] = keccak256(abi.encodePacked(
            componentId, 
            blockhash(block.number - 1), 
            msg.sender, 
            address(this)
        ));

        _safeMint(msg.sender, componentId);
    }

    function tokenURI(uint256 componentId) public view override returns (string memory) {
        require (_exists(componentId), 'Invalid token id');

        bytes memory data = abi.encodePacked(
            'data:application/json;base64,',
            Base64.encode(
                abi.encodePacked(
                    '{',
                        '"name":"Shadow Profile #', componentId.toString(), '",',
                        '"description":"Profile picture component for Shadows composable NFT",',
                        '"external_url":"', BASE_URI, componentId.toString(), '",',
                        '"attributes":[', attributes(componentId), '],'
                        '"image":"data:image/svg+xml;base64,', Base64.encode(abi.encodePacked(
                            '<svg width="255" height="255" xmlns="http://www.w3.org/2000/svg">',
                            image(componentId),
                            '</svg>'
                        )), '"'
                    '}'
                )
            )
        );

        return string(data);
    }
    
    function image(uint256 componentId) public view override returns (bytes memory) {
        return _renderer.image(_seeds[componentId]);
    }
    
    function attributes(uint256 componentId) public view override returns (bytes memory) {
        return _renderer.attributes(_seeds[componentId]);
    }
}
