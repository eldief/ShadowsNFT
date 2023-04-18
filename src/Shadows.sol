// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import "./ShadowsRenderer.sol";
import "./interfaces/IERC2981.sol";
import "./interfaces/IERC4906.sol";
import "./libraries/ShadowsLib.sol";
import "@solady/auth/Ownable.sol";
import "@ERC721A/contracts/ERC721A.sol";

/*
  ██████  ██░ ██  ▄▄▄      ▓█████▄  ▒█████   █     █░  ██████ 
▒██    ▒ ▓██░ ██▒▒████▄    ▒██▀ ██▌▒██▒  ██▒▓█░ █ ░█░▒██    ▒ 
░ ▓██▄   ▒██▀▀██░▒██  ▀█▄  ░██   █▌▒██░  ██▒▒█░ █ ░█ ░ ▓██▄   
  ▒   ██▒░▓█ ░██ ░██▄▄▄▄██ ░▓█▄   ▌▒██   ██░░█░ █ ░█   ▒   ██▒
▒██████▒▒░▓█▒░██▓ ▓█   ▓██▒░▒████▓ ░ ████▓▒░░░██▒██▓ ▒██████▒▒
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▓░▒ ▒  ▒ ▒▓▒ ▒ ░
░ ░▒  ░ ░ ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ▒  ▒   ░ ▒ ▒░   ▒ ░ ░  ░ ░▒  ░ ░
░  ░  ░   ░  ░░ ░  ░   ▒    ░ ░  ░ ░ ░ ░ ▒    ░   ░  ░  ░  ░  
      ░   ░  ░  ░      ░  ░   ░        ░ ░      ░          ░    */

/// @title Shadows
/// @author @eldief
/// @notice `Shadows` NFT
/// @dev Implements `IERC2981`
///      Implements `IERC4906`
///      Uses `ERC721A` for `ERC721` imeplentation
///      Uses `Solady.Ownable` for ownership
///      Uses `ShadowsLib` for packing / unpacking
contract Shadows is IERC2981, IERC4906, ERC721A, Ownable {
    using ShadowsLib for uint256;

    /*
        ┌─┐┬─┐┬─┐┌─┐┬─┐┌─┐
        ├┤ ├┬┘├┬┘│ │├┬┘└─┐
        └─┘┴└─┴└─└─┘┴└─└─┘  */
    /// @notice `InvalidTokenId` error
    error InvalidTokenId();

    /// @notice `InsufficientAmount` error
    error InsufficientAmount();

    /// @notice `OverMaxQuantity` error
    error OverMaxQuantity();

    /// @notice `OverTotalSupply` error
    error OverTotalSupply();

    /// @notice `ZeroQuantity` error
    error ZeroQuantity();

    /*
        ┌─┐┬  ┬┌─┐┌┐┌┌┬┐┌─┐
        ├┤ └┐┌┘├┤ │││ │ └─┐
        └─┘ └┘ └─┘┘└┘ ┴ └─┘ */
    /// @notice `ExpansionSet` event
    event ExpansionSet(uint256 indexed tokenId, uint256 indexed slot, uint8 expansionId, uint16 itemId);

    /*
        ┌─┐┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐
        └─┐ │ │ │├┬┘├─┤│ ┬├┤ 
        └─┘ ┴ └─┘┴└─┴ ┴└─┘└─┘   */
    /// @dev Mapping to `tokenId` to packed `configuration` data
    ///      See `ShadowsLib` for pack / unpack information
    ///      Layout:
    ///      - [0..7]     `Background expansion id`
    ///      - [8..23]    `Background item id`
    ///      - [24..31]   `Head expansion id`
    ///      - [32..47]   `Head item id`
    ///      - [48..55]   `Chest expansion id`
    ///      - [56..71]   `Chest item id`
    ///      - [72..79]   `Shoulders expansion id`
    ///      - [80..95]   `Shoulders item id`
    ///      - [96..103]  `Back expansion id`
    ///      - [104..119] `Back item id`
    ///      - [120..127] `Accessories expansion id`
    ///      - [128..143] `Accessories item id`
    ///      - [144..151] `Hand 1 expansion id`
    ///      - [152..167] `Hand 1 item id`
    ///      - [168..175] `Hand 2 expansion id`
    ///      - [176..191] `Hand 2 item id`
    ///      - [192..255] `Token seed`
    mapping(uint256 => uint256) internal _tokenConfiguration;

    /// @dev Mapping from account to minted amount
    ///      Register minted amount for account in `mint`
    mapping(address => uint256) internal _numMinted;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐   ┬┌┬┐┌┬┐┬ ┬┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐
        │  │ ││││└─┐ │ ───││││││││ │ │ ├─┤├┴┐│  ├┤ └─┐
        └─┘└─┘┘└┘└─┘ ┴    ┴┴ ┴┴ ┴└─┘ ┴ ┴ ┴└─┘┴─┘└─┘└─┘  */
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

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┌─┐┬─┐
        │  │ ││││└─┐ │ ├┬┘│ ││   │ │ │├┬┘
        └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ └─┘┴└─   */
    /// @notice Constructor
    /// @dev Initialize `ERC721A` with `name_` and `symbol_`
    ///      Initialize ownership via `Solady.Ownable`
    ///      Register `ShadowsRenderer` immutable reference
    constructor(address _renderer) ERC721A("Shadows", "SHDWS") {
        _initializeOwner(msg.sender);
        renderer = ShadowsRenderer(_renderer);
    }

    /*
        ┌┬┐┌─┐┌┬┐┬┌─┐┬┌─┐┬─┐┌─┐
        ││││ │ │││├┤ │├┤ ├┬┘└─┐
        ┴ ┴└─┘─┴┘┴└  ┴└─┘┴└─└─┘ */
    /// @notice Modifier to allow only EOAs to access functionality
    /// @dev Reverts with `Unauthorized` when caller is another contract
    modifier onlyEOA() {
        if (tx.origin != msg.sender) {
            revert Unauthorized();
        }
        _;
    }

    /// @notice Modifier to allow only token owner to access functionality
    /// @dev Reverts with `OwnerQueryForNonexistentToken` when token doesn't exist
    ///      Reverts with `Unauthorized` when caller is not token owner
    modifier tokenOwnerOnly(uint256 tokenId) {
        if (msg.sender != ownerOf(tokenId)) {
            revert Unauthorized();
        }
        _;
    }

    /*
        ┌┬┐┬┌┐┌┌┬┐
        │││││││ │ 
        ┴ ┴┴┘└┘ ┴   */
    /// @notice Mint function
    /// @dev Compute and set PRNG packed `seed`, see `ShadowsLib.packSeed` for pack information
    ///      Reverts when called by another contract, see `onlyEOA` modifier for reverts
    ///      Reverts with `OverMaxQuantity` when `quantity` is over `MAX` per account mint
    ///      Reverts with `InsufficientAmount` when `msg.value` is less than `PRICE * quantity`
    ///      Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`
    /// @param to address Recipient
    /// @param quantity uint256 Quantity to be minted
    function mint(address to, uint256 quantity) external payable onlyEOA {
        if (quantity == 0) {
            revert ZeroQuantity();
        }
        if (quantity + _numMinted[msg.sender] > MAX) {
            revert OverMaxQuantity();
        }
        if (msg.value < PRICE * quantity) {
            revert InsufficientAmount();
        }
        if (_nextTokenId() + quantity - 1 > TOTAL_SUPPLY) {
            revert OverTotalSupply();
        }

        _numMinted[msg.sender] += quantity;

        unchecked {
            uint256 index;
            uint256 tokenId = _nextTokenId();

            do {
                uint256 configuration;
                _tokenConfiguration[tokenId] = configuration.packSeed(_seed(msg.sender, tokenId));

                ++index;
                ++tokenId;
            } while (index < quantity);
        }

        _mint(to, quantity);
    }

    /*
        ┬─┐┌─┐┌┐┌┌┬┐┌─┐┬─┐┬┌┐┌┌─┐
        ├┬┘├┤ │││ ││├┤ ├┬┘│││││ ┬
        ┴└─└─┘┘└┘─┴┘└─┘┴└─┴┘└┘└─┘   */
    /// @notice Render a token
    /// @dev Read `tokenConfiguration` from storage
    ///      See `ShadowsRenderer.render` and lower functions for rendering information
    ///      Reverts with `InvalidTokenId` when `tokenId` doesn't exist
    /// @param tokenId uint256 Token id
    /// @return uri string Render result
    function tokenURI(uint256 tokenId) public view override returns (string memory uri) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        uint256 configuration = _tokenConfiguration[tokenId];
        uri = renderer.render(ownerOf(tokenId), tokenId, configuration);
    }

    /*
        ┌─┐┌─┐┌┬┐┌┬┐┌─┐┬─┐┌─┐
        │ ┬├┤  │  │ ├┤ ├┬┘└─┐
        └─┘└─┘ ┴  ┴ └─┘┴└─└─┘   */
    /// @notice Returns `background` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackBackground`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function background(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackBackground();
    }

    /// @notice Returns `head` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackHead`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function head(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackHead();
    }

    /// @notice Returns `chest` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackChest`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function chest(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackChest();
    }

    /// @notice Returns `shoulders` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackShoulders`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function shoulders(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackShoulders();
    }

    /// @notice Returns `back` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackBack`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function back(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackBack();
    }

    /// @notice Returns `accessories` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib._accessories`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function accessories(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackAccessories();
    }

    /// @notice Returns `hand1` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackHand1`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function hand1(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackHand1();
    }

    /// @notice Returns `hand2` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackHand2`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return expansionId uint256 Unpacked `expansionId`
    /// @return itemId uint256 Unpacked `itemId`
    function hand2(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (expansionId, itemId) = _tokenConfiguration[tokenId].unpackHand2();
    }

    /// @notice Returns `seed`
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.unpackSeed`
    ///      Reverts with `InvalidTokenId` when `tokenId` is not valid
    /// @param tokenId uint256 Token id
    /// @return value uint256 Unpacked `seed`
    function seed(uint256 tokenId) external view returns (uint256 value) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }
        (value) = _tokenConfiguration[tokenId].unpackSeed();
    }

    /*
        ┌─┐┌─┐┌┬┐┌┬┐┌─┐┬─┐┌─┐
        └─┐├┤  │  │ ├┤ ├┬┘└─┐
        └─┘└─┘ ┴  ┴ └─┘┴└─└─┘   */
    /// @notice Set `background` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packBackground`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setBackground(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packBackground(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, BACKGROUND_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `head` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packHead`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHead(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packHead(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, HEAD_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `chest` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packChest`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setChest(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packChest(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, CHEST_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `shoulders` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packShoulders`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setShoulders(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packShoulders(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, SHOULDERS_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `back` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packBack`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setBack(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packBack(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, BACK_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `accessories` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packAccessories`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setAccessories(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packAccessories(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, ACCESSORIES_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `hand1` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packHand1`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHand1(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packHand1(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, HAND1_SLOT_ID, expansionId, itemId);
    }

    /// @notice Set `hand2` expansion data
    /// @dev Each expansion data is packed in a single word, see `ShadowsLib.packHand2`
    ///      Delegates verification gas usage to `tokenURI` view function
    ///      See `tokenOwnerOnly` modifier for reverts
    ///      Emit `ERC4906.MetadataUpdate` event
    ///      Emit `ExpansionSet` event
    /// @param tokenId uint256 Token id
    /// @param expansionId uint8 Expansion id
    /// @param itemId uint16 Item id
    function setHand2(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId) {
        uint256 tokenConfiguration = _tokenConfiguration[tokenId];
        _tokenConfiguration[tokenId] = tokenConfiguration.packHand2(expansionId, itemId);

        emit MetadataUpdate(tokenId);
        emit ExpansionSet(tokenId, HAND2_SLOT_ID, expansionId, itemId);
    }

    /*
        ┬─┐┌─┐┬ ┬┌─┐┬  ┌┬┐┬┌─┐┌─┐
        ├┬┘│ │└┬┘├─┤│   │ │├┤ └─┐
        ┴└─└─┘ ┴ ┴ ┴┴─┘ ┴ ┴└─┘└─┘   */
    /// @notice Called with the sale price to determine how much royalty
    //          is owed and to whom
    /// @dev see `IERC2981.royaltyInfo`
    function royaltyInfo(uint256, uint256 _salePrice) external view returns (address receiver, uint256 royaltyAmount) {
        receiver = address(this);
        royaltyAmount = _salePrice * FEES / 10_000;
    }

    /*
        ┬ ┬┬┌┬┐┬ ┬┌┬┐┬─┐┌─┐┬ ┬
        ││││ │ ├─┤ ││├┬┘├─┤│││
        └┴┘┴ ┴ ┴ ┴─┴┘┴└─┴ ┴└┴┘  */
    /// @notice Withdraw collected fees to `to`
    /// @dev See `Solady.Ownable.onlyOwner` modifier for reverts
    /// @param to address Recipient
    function withdraw(address to) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool success,) = payable(to).call{value: balance}("");
        require(success);
    }

    /*
        ┌─┐┬  ┬┌─┐┬─┐┬─┐┬┌┬┐┌─┐┌─┐
        │ │└┐┌┘├┤ ├┬┘├┬┘│ ││├┤ └─┐
        └─┘ └┘ └─┘┴└─┴└─┴─┴┘└─┘└─┘  */
    /// @notice `ERC721A.supportsInterface` override
    /// @dev Add support for `ERC-4906` and `ERC-2981`
    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return interfaceId == type(IERC2981).interfaceId || interfaceId == type(IERC4906).interfaceId
            || super.supportsInterface(interfaceId);
    }

    /// @notice `ERC721A._startTokenId` override
    /// @dev Set first `tokenId` to 1
    /// @return uint256 1
    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    /*
        ┬ ┬┌┬┐┬┬  ┌─┐
        │ │ │ ││  └─┐
        └─┘ ┴ ┴┴─┘└─┘   */
    /// @notice Computes `seed`
    /// @dev Uint64 to be packed within a word with expansions
    /// @param sender address Minter
    /// @param tokenId uint256 Token id
    /// @return result uint64 Seed
    function _seed(address sender, uint256 tokenId) internal view returns (uint64 result) {
        result = uint64(uint256(keccak256(abi.encode(sender, tokenId, block.timestamp))));
    }
}
