# Shadows
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\Shadows.sol)

**Inherits:**
[IERC2981](/src\interfaces\IERC2981.sol\contract.IERC2981.md), [IERC4906](/src\interfaces\IERC4906.sol\contract.IERC4906.md), ERC721A, Ownable

**Author:**
@eldief

`Shadows` NFT

*Implements `IERC2981`
Implements `IERC4906`
Uses `ERC721A` for `ERC721` imeplentation
Uses `Solady.Ownable` for ownership
Uses `ShadowsLib` for packing / unpacking*


## State Variables
### _tokenConfiguration
*Mapping to `tokenId` to packed `configuration` data
See `ShadowsLib` for pack / unpack information
Layout:
- [0..7]     `Background expansion id`
- [8..23]    `Background item id`
- [24..31]   `Head expansion id`
- [32..47]   `Head item id`
- [48..55]   `Chest expansion id`
- [56..71]   `Chest item id`
- [72..79]   `Shoulders expansion id`
- [80..95]   `Shoulders item id`
- [96..103]  `Back expansion id`
- [104..119] `Back item id`
- [120..127] `Accessories expansion id`
- [128..143] `Accessories item id`
- [144..151] `Hand 1 expansion id`
- [152..167] `Hand 1 item id`
- [168..175] `Hand 2 expansion id`
- [176..191] `Hand 2 item id`
- [192..255] `Token seed`*


```solidity
mapping(uint256 => uint256) internal _tokenConfiguration;
```


### _numMinted
*Mapping from account to minted amount
Register minted amount for account in `mint`*


```solidity
mapping(address => uint256) internal _numMinted;
```


### FEES
Royalties fees in BPs


```solidity
uint256 public constant FEES = 500;
```


### MAX
Max quantity per mint


```solidity
uint256 public constant MAX = 2;
```


### PRICE
Price per mint


```solidity
uint256 public constant PRICE = 0.01 ether;
```


### TOTAL_SUPPLY
Total max supply


```solidity
uint256 public constant TOTAL_SUPPLY = 10_000;
```


### renderer
`ShadowsRenderer` immutable contract reference


```solidity
ShadowsRenderer public immutable renderer;
```


## Functions
### constructor

Constructor

*Initialize `ERC721A` with `name_` and `symbol_`
Initialize ownership via `Solady.Ownable`
Register `ShadowsRenderer` immutable reference*


```solidity
constructor(address _renderer) ERC721A("Shadows", "SHDWS");
```

### onlyEOA

Modifier to allow only EOAs to access functionality

*Reverts with `Unauthorized` when caller is another contract*


```solidity
modifier onlyEOA();
```

### tokenOwnerOnly

Modifier to allow only token owner to access functionality

*Reverts with `OwnerQueryForNonexistentToken` when token doesn't exist
Reverts with `Unauthorized` when caller is not token owner*


```solidity
modifier tokenOwnerOnly(uint256 tokenId);
```

### mint

Mint function

*Compute and set PRNG packed `seed`, see `ShadowsLib.packSeed` for pack information
Reverts when called by another contract, see `onlyEOA` modifier for reverts
Reverts with `OverMaxQuantity` when `quantity` is over `MAX` per account mint
Reverts with `InsufficientAmount` when `msg.value` is less than `PRICE * quantity`
Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`*


```solidity
function mint(address to, uint256 quantity) external payable onlyEOA;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|address Recipient|
|`quantity`|`uint256`|uint256 Quantity to be minted|


### tokenURI

Render a token

*Read `tokenConfiguration` from storage
See `ShadowsRenderer.render` and lower functions for rendering information
Reverts with `InvalidTokenId` when `tokenId` doesn't exist*


```solidity
function tokenURI(uint256 tokenId) public view override returns (string memory uri);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`uri`|`string`|string Render result|


### background

Returns `background` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackBackground`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function background(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### head

Returns `head` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackHead`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function head(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### chest

Returns `chest` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackChest`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function chest(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### shoulders

Returns `shoulders` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackShoulders`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function shoulders(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### back

Returns `back` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackBack`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function back(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### accessories

Returns `accessories` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib._accessories`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function accessories(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### hand1

Returns `hand1` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackHand1`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function hand1(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### hand2

Returns `hand2` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.unpackHand2`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function hand2(uint256 tokenId) external view returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### seed

Returns `seed`

*Each expansion data is packed in a single word, see `ShadowsLib.unpackSeed`
Reverts with `InvalidTokenId` when `tokenId` is not valid*


```solidity
function seed(uint256 tokenId) external view returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `seed`|


### setBackground

Set `background` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packBackground`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setBackground(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setHead

Set `head` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packHead`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setHead(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setChest

Set `chest` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packChest`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setChest(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setShoulders

Set `shoulders` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packShoulders`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setShoulders(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setBack

Set `back` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packBack`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setBack(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setAccessories

Set `accessories` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packAccessories`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setAccessories(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setHand1

Set `hand1` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packHand1`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setHand1(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### setHand2

Set `hand2` expansion data

*Each expansion data is packed in a single word, see `ShadowsLib.packHand2`
Delegates verification gas usage to `tokenURI` view function
See `tokenOwnerOnly` modifier for reverts
Emit `ERC4906.MetadataUpdate` event
Emit `ExpansionSet` event*


```solidity
function setHand2(uint256 tokenId, uint8 expansionId, uint16 itemId) external tokenOwnerOnly(tokenId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|


### royaltyInfo

Called with the sale price to determine how much royalty

*see `IERC2981.royaltyInfo`*


```solidity
function royaltyInfo(uint256, uint256 _salePrice) external view returns (address receiver, uint256 royaltyAmount);
```

### withdraw

Withdraw collected fees to `to`

*See `Solady.Ownable.onlyOwner` modifier for reverts*


```solidity
function withdraw(address to) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|address Recipient|


### supportsInterface

`ERC721A.supportsInterface` override

*Add support for `ERC-4906` and `ERC-2981`*


```solidity
function supportsInterface(bytes4 interfaceId) public view override returns (bool);
```

### _startTokenId

`ERC721A._startTokenId` override

*Set first `tokenId` to 1*


```solidity
function _startTokenId() internal pure override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 1|


### _seed

Computes `seed`

*Uint64 to be packed within a word with expansions*


```solidity
function _seed(address sender, uint256 tokenId) internal view returns (uint64 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`sender`|`address`|address Minter|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint64`|uint64 Seed|


## Events
### ExpansionSet
`ExpansionSet` event


```solidity
event ExpansionSet(uint256 indexed tokenId, uint256 indexed slot, uint8 expansionId, uint16 itemId);
```

## Errors
### InvalidTokenId
`InvalidTokenId` error


```solidity
error InvalidTokenId();
```

### InsufficientAmount
`InsufficientAmount` error


```solidity
error InsufficientAmount();
```

### OverMaxQuantity
`OverMaxQuantity` error


```solidity
error OverMaxQuantity();
```

### OverTotalSupply
`OverTotalSupply` error


```solidity
error OverTotalSupply();
```

### ZeroQuantity
`ZeroQuantity` error


```solidity
error ZeroQuantity();
```

