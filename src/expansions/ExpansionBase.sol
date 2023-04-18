// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "../libraries/ExpansionsLib.sol";
import "../interfaces/IExpansionRenderer.sol";
import "../interfaces/IERC2981.sol";
import "../interfaces/IERC4906.sol";
import "@solady/auth/Ownable.sol";
import "@solady/utils/LibString.sol";
import "@solady/utils/DynamicBufferLib.sol";
import "@ERC721A/contracts/ERC721A.sol";

/// @title ExpansionBase
/// @author @eldief
/// @notice Contract defining shared functionalities for `Expansions`
/// @dev Abstract contract
///      Implements `IExpansionRenderer` for `Shadows` equipment rendering
///      Implements `IERC2981`
///      Implements `IERC4906`
///      Uses `ERC721A` for `ERC721` implementation
///      Uses `Solady.Ownable` for ownership
///      Uses `ExpansionsLib` for packing / unpacking
///      Uses `Solady.LibString` for string manipulation
///      Uses `Solady.DynamicBufferLib` for bytes concatenation
abstract contract ExpansionBase is IExpansionRenderer, IERC2981, IERC4906, ERC721A, Ownable {
    using LibString for uint256;
    using ExpansionsLib for uint256;
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

    /*
        ┌─┐┬─┐┬─┐┌─┐┬─┐┌─┐
        ├┤ ├┬┘├┬┘│ │├┬┘└─┐
        └─┘┴└─┴└─└─┘┴└─└─┘  */
    /// @notice `AlreadyClaimed` error
    error AlreadyClaimed();

    /// @notice `AlreadyRevealed` error
    error AlreadyRevealed();

    /// @notice `ClaimPeriodNotFinished` error
    error ClaimPeriodNotFinished();

    /// @notice `InvalidTokenId` error
    error InvalidTokenId();

    /// @notice `InsufficientAmount` error
    error InsufficientAmount();

    /// @notice `NotShadowOwner` error
    error NotShadowOwner();

    /// @notice `OverMaxQuantity` error
    error OverMaxQuantity();

    /// @notice `OverTotalSupply` error
    error OverTotalSupply();

    /// @notice `PublicMintNotStartedYet` error
    error PublicMintNotStartedYet();

    /// @notice `PublicMintStarted` error
    error PublicMintStarted();

    /// @notice `PriceTooHigh` error
    error PriceTooHigh();

    /// @notice `RoyaltiesTooHigh` error
    error RoyaltiesTooHigh();

    /// @notice `ZeroQuantity` error
    error ZeroQuantity();

    /*
        ┌─┐┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐
        └─┐ │ │ │├┬┘├─┤│ ┬├┤ 
        └─┘ ┴ └─┘┴└─┴ ┴└─┘└─┘   */
    /// @dev Packed expansion `configuration`
    ///      See `ExpansionsLib` for pack / unpack information
    ///      Layout:
    ///      - [0..63]     `Reveal salt`
    ///      - [64..127]   `Claim end / public mint start timestamp`
    ///      - [128..143]  `Royalties fees in BPs`
    ///      - [144..151]  `Max quantity per mint`
    ///      - [152..167]  `Total max supply`
    ///      - [168..199]  `Price per mint in gwei`
    uint256 internal _configuration;

    /// @dev Mapping from `tokenId` to packed token `configuration`
    ///      See `ExpansionsLib` for pack / unpack information
    ///      Layout:
    ///      - [0..63]     `Token seed`
    ///      - [64..256]   TBD
    mapping(uint256 => uint256) internal _tokenConfiguration;

    /// @dev Mapping from `tokenId` to `claimed`
    ///      Register claimed `tokenIds` in claim phase
    mapping(uint256 => bool) internal _claimed;

    /// @dev Mapping from account to minted amount
    ///      Register minted amount for account in `publicSale`
    mapping(address => uint256) internal _numMinted;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐   ┬┌┬┐┌┬┐┬ ┬┌┬┐┌─┐┌┐ ┬  ┌─┐┌─┐
        │  │ ││││└─┐ │ ───││││││││ │ │ ├─┤├┴┐│  ├┤ └─┐
        └─┘└─┘┘└┘└─┘ ┴    ┴┴ ┴┴ ┴└─┘ ┴ ┴ ┴└─┘┴─┘└─┘└─┘  */
    /// @notice `Shadows` immutable contract reference
    IERC721A public immutable shadows;

    /*
        ┌─┐┌─┐┌┐┌┌─┐┌┬┐┬─┐┬ ┬┌─┐┌┬┐┌─┐┬─┐
        │  │ ││││└─┐ │ ├┬┘│ ││   │ │ │├┬┘
        └─┘└─┘┘└┘└─┘ ┴ ┴└─└─┘└─┘ ┴ └─┘┴└─   */
    /// @notice Constructor
    /// @dev Initialize `ERC721A` with `name_` and `symbol_`
    ///      Initialize ownership via `Solady.Ownable`
    ///      Register `Shadows` immutable reference
    constructor(address shadows_, string memory name_, string memory symbol_) ERC721A(name_, symbol_) {
        _initializeOwner(msg.sender);
        shadows = IERC721A(shadows_);
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

    /*
        ┌┬┐┬┌┐┌┌┬┐
        │││││││ │ 
        ┴ ┴┴┘└┘ ┴   */
    /// @notice Public mint function, open after `isClaimPeriodOver`
    /// @dev Compute and set PRNG packed `seed`, see `ExpansionsLib.packSeed` for pack information
    ///      Can be overridden by expansion pack contract
    ///      Reverts when called by another contract, see `onlyEOA` modifier for reverts
    ///      Reverts with `ZeroQuantity` when `quantity` is 0
    ///      Reverts with `OverMaxQuantity` when `quantity` is over `MAX` per account mint
    ///      Reverts with `InsufficientAmount` when `msg.value` is less than `PRICE * quantity`
    ///      Reverts with `PublicMintNotStartedYet` when claim phase is on-going
    ///      Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`
    /// @param to address Recipient
    /// @param quantity uint256 Quantity to be minted
    function mint(address to, uint256 quantity) external payable virtual onlyEOA {
        uint256 configuration = _configuration;

        if (quantity == 0) {
            revert ZeroQuantity();
        }
        if (quantity + _numMinted[msg.sender] > configuration.unpackMaxQuantity()) {
            revert OverMaxQuantity();
        }
        if (msg.value < configuration.unpackPrice() * quantity) {
            revert InsufficientAmount();
        }
        if (block.timestamp < configuration.unpackClaimEnd()) {
            revert PublicMintNotStartedYet();
        }
        if (_nextTokenId() + quantity - 1 > configuration.unpackMaxTotalSupply()) {
            revert OverTotalSupply();
        }

        _numMinted[msg.sender] += quantity;

        unchecked {
            uint256 index;
            uint256 tokenId = _nextTokenId();

            do {
                uint256 tokenConfiguration;
                _tokenConfiguration[tokenId] = tokenConfiguration.packSeed(_seed(msg.sender, tokenId));

                ++index;
                ++tokenId;
            } while (index < quantity);
        }

        _mint(to, quantity);
    }

    /// @notice `Shadows` holders claim function, open before `isClaimPeriodOver`
    /// @dev Compute and set PRNG packed `seed`, see `ExpansionsLib.packSeed` for pack information
    ///      Can be overridden by expansion pack contract
    ///      Reverts with `ZeroQuantity` when `quantity` is 0
    ///      Reverts with `PublicMintStarted` when claim phase is over
    ///      Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`
    ///      Reverts with `AlreadyClaimed` when `tokenId` has already claimed
    ///      Reverts with `NotShadowOwner` when `msg.sender` is not owner of `tokenId`
    /// @param to address Recipient
    /// @param tokenIds uint256[] Token ids to be claimed for
    function claim(address to, uint256[] calldata tokenIds) external virtual {
        uint256 length = tokenIds.length;
        uint256 configuration = _configuration;

        if (length == 0) {
            revert ZeroQuantity();
        }
        if (block.timestamp >= configuration.unpackClaimEnd()) {
            revert PublicMintStarted();
        }
        if (_nextTokenId() + length - 1 > configuration.unpackMaxTotalSupply()) {
            revert OverTotalSupply();
        }

        unchecked {
            uint256 index;
            uint256 tokenId = _nextTokenId();

            do {
                uint256 shadowsId = tokenIds[index];

                if (_claimed[shadowsId]) {
                    revert AlreadyClaimed();
                }
                if (msg.sender != shadows.ownerOf(shadowsId)) {
                    revert NotShadowOwner();
                }

                _claimed[shadowsId] = true;

                uint256 tokenConfiguration;
                _tokenConfiguration[tokenId] = tokenConfiguration.packSeed(_seed(msg.sender, tokenId));

                ++index;
                ++tokenId;
            } while (index < length);
        }

        _mint(to, length);
    }

    /*
        ┬─┐┌─┐┬  ┬┌─┐┌─┐┬  
        ├┬┘├┤ └┐┌┘├┤ ├─┤│  
        ┴└─└─┘ └┘ └─┘┴ ┴┴─┘ */
    /// @notice Reveal collection
    /// @dev Inject `salt` into `configuration` shuffling collection metadata
    ///      Reverts with `Unauthorized` when called is not owner
    ///      Reverts with `AlreadyRevealed` when `salt` is already set
    ///      Reverts with `ClaimPeriodNotFinished` when claim period is not over
    ///      Emit `ERC4906.BatchMetadataUpdate` for the whole collection
    function reveal() external onlyOwner {
        uint256 configuration = _configuration;

        if (configuration.unpackSalt() != 0) {
            revert AlreadyRevealed();
        }
        if (block.timestamp < configuration.unpackClaimEnd()) {
            revert ClaimPeriodNotFinished();
        }

        uint64 salt = uint64(uint256(keccak256(abi.encode(msg.sender, block.timestamp))));
        _configuration = configuration.packSalt(salt);

        emit BatchMetadataUpdate(_startTokenId(), type(uint256).max);
    }

    /*
        ┬─┐┌─┐┌┐┌┌┬┐┌─┐┬─┐┬┌┐┌┌─┐
        ├┬┘├┤ │││ ││├┤ ├┬┘│││││ ┬
        ┴└─└─┘┘└┘─┴┘└─┘┴└─┴┘└┘└─┘   */
    /// @notice Render a token
    /// @dev On-chain render for `Shadows Expansions` NFT
    ///      See specific `Expansion` for rendering information
    ///      Reverts with `InvalidTokenId` when `tokenId` doesn't exist
    /// @param tokenId uint256 Token id
    /// @return uri string On-chain svg Base64 encoded
    function tokenURI(uint256 tokenId) public view override returns (string memory uri) {
        if (!_exists(tokenId)) {
            revert InvalidTokenId();
        }

        (, bytes memory attributes, bytes memory image) = render(tokenId);
        DynamicBufferLib.DynamicBuffer memory resultBuffer = DynamicBufferLib.DynamicBuffer("data:application/json,{");
        {
            resultBuffer.append('"name":"', bytes(name()), " #", bytes(tokenId.toString()), '",');
            resultBuffer.append('"description":"', "", '",');
            resultBuffer.append('"attributes":[', attributes, "],");
            resultBuffer.append('"image":"', image, '"}');
        }
        uri = string(resultBuffer.data);
    }

    /// @notice Render attributes and image for `tokenId`
    /// @dev Check that expansion is revealed
    ///      Uses `seed xor salt` as seed for shuffling revealed metadata
    ///      Rendering behaviour for both `revealed` and `unrevelead` are to be overridden by each `Expansion`
    ///      Buffers are instanciated here and passed by reference to internal functions
    /// @param tokenId uint256 Token id
    /// @return slotId uint256 Token slot id
    /// @return attributes bytes Token attributes
    /// @return image bytes Token image
    function render(uint256 tokenId)
        public
        view
        returns (uint256 slotId, bytes memory attributes, bytes memory image)
    {
        DynamicBufferLib.DynamicBuffer memory attributesBuffer;
        DynamicBufferLib.DynamicBuffer memory imageBuffer;

        uint256 salt = _configuration.unpackSalt();
        uint256 seed = _tokenConfiguration[tokenId].unpackSeed();

        if (salt > 0) {
            slotId = _renderRevealed(attributesBuffer, imageBuffer, seed ^ salt, tokenId);
        } else {
            slotId = _renderUnrevealed(attributesBuffer, imageBuffer, seed, tokenId);
        }

        attributes = attributesBuffer.data;
        image = imageBuffer.data;
    }

    /// @notice Render unrevealed `Expansion` pack
    /// @dev Internal render function to be overridden by expansion implementation
    ///      Buffers are passed by reference to save gas while appending data
    /// @param attributesBuffer DynamicBufferLib.DynamicBuffer for attributes metadata
    /// @param imageBuffer DynamicBufferLib.DynamicBuffer for image metadata
    /// @param tokenId uint256 Token id
    function _renderUnrevealed(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        uint256 seed,
        uint256 tokenId
    ) internal view virtual returns (uint256 slotId) {}

    /// @notice Render revealed `Expansion` pack
    /// @dev Internal render function to be overridden by expansion implementation
    ///      Buffers are passed by reference to save gas while appending data
    /// @param attributesBuffer DynamicBufferLib.DynamicBuffer for attributes metadata
    /// @param imageBuffer DynamicBufferLib.DynamicBuffer for image metadata
    /// @param seed uint256 Revealed seed
    /// @param tokenId uint256 Token id
    function _renderRevealed(
        DynamicBufferLib.DynamicBuffer memory attributesBuffer,
        DynamicBufferLib.DynamicBuffer memory imageBuffer,
        uint256 seed,
        uint256 tokenId
    ) internal view virtual returns (uint256 slotId) {}

    /*
        ┌─┐┌─┐┌┬┐┌┬┐┌─┐┬─┐┌─┐
        │ ┬├┤  │  │ ├┤ ├┬┘└─┐
        └─┘└─┘ ┴  ┴ └─┘┴└─└─┘   */
    /// @notice Returns `claimPeriodEnd` timestamp
    /// @dev See 'ExpansionsLib.unpackClaimEnd' for details
    ///      Can be modified by 'owner'
    /// @return value uint256 Unpacked `claimPeriodEnd` timestamp
    function claimPeriodEnd() public view returns (uint256 value) {
        value = _configuration.unpackClaimEnd();
    }

    /// @notice Returns `true` when claim period is over, `false` otherwise
    /// @dev See 'claimPeriodEnd' for details
    /// @return ended bool Is claim period over
    function isClaimPeriodOver() public view returns (bool ended) {
        ended = block.timestamp < claimPeriodEnd();
    }

    /// @notice Returns `royalties`
    /// @dev See `ExpansionsLib.unpackRoyalties`
    ///      Can be modified by 'owner'
    /// @return value uint256 Unpacked `royalties`
    function royalties() external view returns (uint256 value) {
        value = _configuration.unpackRoyalties();
    }

    /// @notice Returns `maxQuantity`
    /// @dev See `ExpansionsLib.unpackMaxQuantity`
    ///      Cannot be modified by 'owner'
    /// @return value uint256 Unpacked `maxQuantity`
    function maxQuantity() external view returns (uint256 value) {
        value = _configuration.unpackMaxQuantity();
    }

    /// @notice Returns `maxTotalSupply`
    /// @dev See `ExpansionsLib.unpackMaxTotalSupply`
    ///      Cannot be modified by 'owner'
    /// @return value uint256 Unpacked `maxTotalSupply`
    function maxTotalSupply() external view returns (uint256 value) {
        value = _configuration.unpackMaxTotalSupply();
    }

    /// @notice Returns `price`
    /// @dev See `ExpansionsLib.unpackPrice`
    ///      Can be modified by 'owner'
    /// @return value uint256 Unpacked `price`
    function price() external view returns (uint256 value) {
        value = _configuration.unpackPrice();
    }

    /*
        ┌─┐┌─┐┌┬┐┌┬┐┌─┐┬─┐┌─┐
        └─┐├┤  │  │ ├┤ ├┬┘└─┐
        └─┘└─┘ ┴  ┴ └─┘┴└─└─┘   */
    /// @notice Set `claimEnd` configuration
    /// @dev See `ShadowsLib.packClaimEnd`
    ///      See `Solady.Ownable.onlyOwner` modifier for reverts
    /// @param value uint64 Claim end timestamp
    function setClaimEnd(uint64 value) external onlyOwner {
        uint256 configuration = _configuration;
        _configuration = configuration.packClaimEnd(value);
    }

    /// @notice Set `royalties` configuration
    /// @dev See `ShadowsLib.packRoyalties`
    ///      See `Solady.Ownable.onlyOwner` modifier for reverts
    ///      Reverts with `RoyaltiesTooHigh` when royalties `value` > 10%
    /// @param value uint16 Royalties amount in BPs
    function setRoyalties(uint16 value) external onlyOwner {
        if (value > 1_000) {
            revert RoyaltiesTooHigh(); // Max royalties 10%
        }
        uint256 configuration = _configuration;
        _configuration = configuration.packRoyalties(value);
    }

    /// @notice Set `price` configuration
    /// @dev See `ShadowsLib.packRoyalties`
    ///      See `Solady.Ownable.onlyOwner` modifier for reverts
    ///      Reverts with `PriceTooHigh` when `value` > 1 ether
    /// @param value uint32 Price in gwei
    function setPrice(uint32 value) external onlyOwner {
        if (value > 1 ether / 1 gwei) {
            revert PriceTooHigh(); // Max price 1 ether
        }
        uint256 configuration = _configuration;
        _configuration = configuration.packPrice(value);
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
        royaltyAmount = _salePrice * _configuration.unpackRoyalties() / 10_000;
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
    function _startTokenId() internal pure virtual override returns (uint256) {
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
