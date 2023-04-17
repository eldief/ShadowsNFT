// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";

import "./ShadowsRenderer.sol";
import "./libraries/EquipmentLib.sol";
import "@ERC721A/contracts/ERC721A.sol";

contract Shadows is EquippableInternal, ERC721A {
    /// @notice `InvalidTokenId` error
    error InvalidTokenId();

    /// @notice `InsufficientAmount` error
    error InsufficientAmount();

    /// @notice `OverMaxQuantity` error
    error OverMaxQuantity();

    /// @notice `OverTotalSupply` error
    error OverTotalSupply();

    /// @notice `Unauthorized` error
    error Unauthorized();

    /// @notice `ZeroQuantity` error
    error ZeroQuantity();

    /// @notice `ExpansionSet` event
    event ExpansionSet(uint256 indexed tokenId, uint256 indexed slot, uint8 expansionId, uint16 itemId);

    /// @dev Mapping to `tokenId` to packed `equipment` data
    //       Layout:
    //       - [0..7]     `Background expansion id`
    //       - [8..23]    `Background item id`
    //       - [24..31]   `Head expansion id`
    //       - [32..47]   `Head item id`
    //       - [48..55]   `Chest expansion id`
    //       - [56..71]   `Chest item id`
    //       - [72..79]   `Shoulders expansion id`
    //       - [80..95]   `Shoulders item id`
    //       - [96..103]  `Back expansion id`
    //       - [104..119] `Back item id`
    //       - [120..127] `Accessories expansion id`
    //       - [128..143] `Accessories item id`
    //       - [144..151] `Hand 1 expansion id`
    //       - [152..167] `Hand 1 item id`
    //       - [168..175] `Hand 2 expansion id`
    //       - [176..191] `Hand 2 item id`
    //       - [192..255] `Seed`
    mapping(uint256 => uint256) internal _equipment;

    /// @notice Royalties fees in BPs
    uint256 public constant FEES = 500;

    /// @notice Max quantity per mint
    uint256 public constant MAX = 2;

    /// @notice Price per mint
    uint256 public constant PRICE = 0.01 ether;

    /// @notice Total max supply
    uint256 public constant TOTAL_SUPPLY = 10_000;

    /// @notice `ShadowsRenderer` immutable contract reference
    ShadowsRenderer public immutable renderer;

    /// @notice Constructor
    /// @dev Initialize `ERC721A` with `name` and `symbol`
    /// @dev Register `ShadowsRenderer` immutable reference
    constructor(address _renderer) ERC721A("Shadows", "SHDW") {
        renderer = ShadowsRenderer(_renderer);
    }

    /// @notice Modifier to allow only token owner to access functionality
    /// @dev Reverts with `OwnerQueryForNonexistentToken` when token doesn't exist
    ///      Reverts with `Unauthorized` when caller is not token owner
    modifier tokenOwnerOnly(uint256 tokenId) {
        if (msg.sender != ownerOf(tokenId)) revert Unauthorized();
        _;
    }

    /// @notice Mint function
    /// @dev Compute and set PRNG packed `seed`, see `EquippableInternal._packSeed` for pack information
    ///      Reverts with `OverMaxQuantity` when `quantity` is over `MAX` per mint
    ///      Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`
    ///      Reverts with `InsufficientAmount` when `msg.value` is less than `PRICE * quantity`
    /// @param quantity uint256 Amount to be minted in this transaction
    function mint(uint256 quantity) external payable {
        if (quantity == 0) revert ZeroQuantity();
        if (quantity > MAX) revert OverMaxQuantity();
        if (totalSupply() + quantity > TOTAL_SUPPLY) revert OverTotalSupply();
        if (msg.value < PRICE * quantity) revert InsufficientAmount();

        unchecked {
            uint256 index;
            uint256 tokenId = _nextTokenId();

            do {
                _equipment[tokenId] = _packSeed(_computeSeed(msg.sender, tokenId));

                ++index;
                ++tokenId;
            } while (index < quantity);
        }

        _mint(msg.sender, quantity);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory uri) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        uint256 equipment = _equipment[tokenId];
        uri = renderer.render(ownerOf(tokenId), tokenId, equipment);
    }

    /// @notice `ERC721A._startTokenId` override
    /// @dev Set first `tokenId` to 1
    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    /// @notice Computes `seed`
    /// @dev Uint64 to be packed within a word with expansions
    function _computeSeed(address sender, uint256 tokenId) internal view returns (uint64 result) {
        result = uint64(uint256(keccak256(abi.encode(sender, tokenId, block.timestamp))));
    }

    /// @notice Returns `background` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._background`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function background(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _background(_equipment[tokenId]);
    }

    /// @notice Set `background` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._background`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setBackground(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packBackground(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, BACKGROUND_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `head` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._head`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function head(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _head(_equipment[tokenId]);
    }

    /// @notice Set `head` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._head`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHead(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packHead(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, HEAD_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `chest` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._chest`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function chest(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _chest(_equipment[tokenId]);
    }

    /// @notice Set `chest` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._chest`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setChest(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packChest(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, CHEST_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `shoulders` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._shoulders`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function shoulders(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _shoulders(_equipment[tokenId]);
    }

    /// @notice Set `shoulders` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._shoulders`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setShoulders(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packShoulders(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, SHOULDERS_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `back` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._back`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function back(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _back(_equipment[tokenId]);
    }

    /// @notice Set `back` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._back`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setBack(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packBack(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, BACK_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `accessories` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._accessories`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function accessories(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _accessories(_equipment[tokenId]);
    }

    /// @notice Set `accessories` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._accessories`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setAccessories(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packAccessories(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, ACCESSORIES_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `hand1` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._hand1`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function hand1(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _hand1(_equipment[tokenId]);
    }

    /// @notice Set `hand1` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._hand1`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHand1(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packHand1(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, HAND1_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `hand2` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._hand2`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function hand2(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (expansionId, itemId) = _hand2(_equipment[tokenId]);
    }

    /// @notice Set `hand2` expansion data
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._hand2`
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHand2(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 equipment = _equipment[tokenId];
        equipment = _packHand2(equipment, expansionId, itemId);
        _equipment[tokenId] = equipment;

        emit ExpansionSet(tokenId, HAND2_SLOT_ID, expansionId, itemId);
    }

    /// @notice Returns `seed`
    /// @dev Each expansion data is packed in a single word, see `EquippableInternal._seed`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return value uint256 Unpacked `seed`
    function seed(uint256 tokenId) external view returns (uint256 value) {
        if (!_exists(tokenId)) revert InvalidTokenId();
        (value) = _seed(_equipment[tokenId]);
    }
}
