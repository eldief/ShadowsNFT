# ExpansionBase
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\expansions\ExpansionBase.sol)

**Inherits:**
[IExpansionRenderer](/src\interfaces\IExpansionRenderer.sol\contract.IExpansionRenderer.md), [IERC2981](/src\interfaces\IERC2981.sol\contract.IERC2981.md), [IERC4906](/src\interfaces\IERC4906.sol\contract.IERC4906.md), ERC721A, Ownable

**Author:**
@eldief

Contract defining shared functionalities for `Expansions`

*Abstract contract
Implements `IExpansionRenderer` for `Shadows` equipment rendering
Implements `IERC2981`
Implements `IERC4906`
Uses `ERC721A` for `ERC721` implementation
Uses `Solady.Ownable` for ownership
Uses `ExpansionsLib` for packing / unpacking
Uses `Solady.LibString` for string manipulation
Uses `Solady.DynamicBufferLib` for bytes concatenation*


## State Variables
### _configuration
*Packed expansion `configuration`
See `ExpansionsLib` for pack / unpack information
Layout:
- [0..63]     `Reveal salt`
- [64..127]   `Claim end / public mint start timestamp`
- [128..143]  `Royalties fees in BPs`
- [144..151]  `Max quantity per mint`
- [152..167]  `Total max supply`
- [168..199]  `Price per mint in gwei`*


```solidity
uint256 internal _configuration;
```


### _tokenConfiguration
*Mapping from `tokenId` to packed token `configuration`
See `ExpansionsLib` for pack / unpack information
Layout:
- [0..63]     `Token seed`
- [64..256]   TBD*


```solidity
mapping(uint256 => uint256) internal _tokenConfiguration;
```


### _claimed
*Mapping from `tokenId` to `claimed`
Register claimed `tokenIds` in claim phase*


```solidity
mapping(uint256 => bool) internal _claimed;
```


### _numMinted
*Mapping from account to minted amount
Register minted amount for account in `publicSale`*


```solidity
mapping(address => uint256) internal _numMinted;
```


### shadows
`Shadows` immutable contract reference


```solidity
IERC721A public immutable shadows;
```


## Functions
### constructor

Constructor

*Initialize `ERC721A` with `name_` and `symbol_`
Initialize ownership via `Solady.Ownable`
Register `Shadows` immutable reference*


```solidity
constructor(address shadows_, string memory name_, string memory symbol_) ERC721A(name_, symbol_);
```

### onlyEOA

Modifier to allow only EOAs to access functionality

*Reverts with `Unauthorized` when caller is another contract*


```solidity
modifier onlyEOA();
```

### mint

Public mint function, open after `isClaimPeriodOver`

*Compute and set PRNG packed `seed`, see `ExpansionsLib.packSeed` for pack information
Can be overridden by expansion pack contract
Reverts when called by another contract, see `onlyEOA` modifier for reverts
Reverts with `ZeroQuantity` when `quantity` is 0
Reverts with `OverMaxQuantity` when `quantity` is over `MAX` per account mint
Reverts with `InsufficientAmount` when `msg.value` is less than `PRICE * quantity`
Reverts with `PublicMintNotStartedYet` when claim phase is on-going
Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`*


```solidity
function mint(address to, uint256 quantity) external payable virtual onlyEOA;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|address Recipient|
|`quantity`|`uint256`|uint256 Quantity to be minted|


### claim

`Shadows` holders claim function, open before `isClaimPeriodOver`

*Compute and set PRNG packed `seed`, see `ExpansionsLib.packSeed` for pack information
Can be overridden by expansion pack contract
Reverts with `ZeroQuantity` when `quantity` is 0
Reverts with `PublicMintStarted` when claim phase is over
Reverts with `OverTotalSupply` when `currentSupply + quantity` is over `TOTAL_SUPPLY`
Reverts with `AlreadyClaimed` when `tokenId` has already claimed
Reverts with `NotShadowOwner` when `msg.sender` is not owner of `tokenId`*


```solidity
function claim(address to, uint256[] calldata tokenIds) external virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|address Recipient|
|`tokenIds`|`uint256[]`|uint256[] Token ids to be claimed for|


### reveal

Reveal collection

*Inject `salt` into `configuration` shuffling collection metadata
Reverts with `Unauthorized` when called is not owner
Reverts with `AlreadyRevealed` when `salt` is already set
Reverts with `ClaimPeriodNotFinished` when claim period is not over
Emit `ERC4906.BatchMetadataUpdate` for the whole collection*


```solidity
function reveal() external onlyOwner;
```

### tokenURI

Render a token

*On-chain render for `Shadows Expansions` NFT
See specific `Expansion` for rendering information
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
|`uri`|`string`|string On-chain svg Base64 encoded|


### render

Render attributes and image for `tokenId`

*Check that expansion is revealed
Uses `seed xor salt` as seed for shuffling revealed metadata
Rendering behaviour for both `revealed` and `unrevelead` are to be overridden by each `Expansion`
Buffers are instanciated here and passed by reference to internal functions*


```solidity
function render(uint256 tokenId) public view returns (uint256 slotId, bytes memory attributes, bytes memory image);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|uint256 Token id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`slotId`|`uint256`|uint256 Token slot id|
|`attributes`|`bytes`|bytes Token attributes|
|`image`|`bytes`|bytes Token image|


### _renderUnrevealed

Render unrevealed `Expansion` pack

*Internal render function to be overridden by expansion implementation
Buffers are passed by reference to save gas while appending data*


```solidity
function _renderUnrevealed(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    uint256 seed,
    uint256 tokenId
) internal view virtual returns (uint256 slotId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`attributesBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for attributes metadata|
|`imageBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for image metadata|
|`seed`|`uint256`||
|`tokenId`|`uint256`|uint256 Token id|


### _renderRevealed

Render revealed `Expansion` pack

*Internal render function to be overridden by expansion implementation
Buffers are passed by reference to save gas while appending data*


```solidity
function _renderRevealed(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    uint256 seed,
    uint256 tokenId
) internal view virtual returns (uint256 slotId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`attributesBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for attributes metadata|
|`imageBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for image metadata|
|`seed`|`uint256`|uint256 Revealed seed|
|`tokenId`|`uint256`|uint256 Token id|


### claimPeriodEnd

Returns `claimPeriodEnd` timestamp

*See 'ExpansionsLib.unpackClaimEnd' for details
Can be modified by 'owner'*


```solidity
function claimPeriodEnd() public view returns (uint256 value);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `claimPeriodEnd` timestamp|


### isClaimPeriodOver

Returns `true` when claim period is over, `false` otherwise

*See 'claimPeriodEnd' for details*


```solidity
function isClaimPeriodOver() public view returns (bool ended);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`ended`|`bool`|bool Is claim period over|


### royalties

Returns `royalties`

*See `ExpansionsLib.unpackRoyalties`
Can be modified by 'owner'*


```solidity
function royalties() external view returns (uint256 value);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `royalties`|


### maxQuantity

Returns `maxQuantity`

*See `ExpansionsLib.unpackMaxQuantity`
Cannot be modified by 'owner'*


```solidity
function maxQuantity() external view returns (uint256 value);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `maxQuantity`|


### maxTotalSupply

Returns `maxTotalSupply`

*See `ExpansionsLib.unpackMaxTotalSupply`
Cannot be modified by 'owner'*


```solidity
function maxTotalSupply() external view returns (uint256 value);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `maxTotalSupply`|


### price

Returns `price`

*See `ExpansionsLib.unpackPrice`
Can be modified by 'owner'*


```solidity
function price() external view returns (uint256 value);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `price`|


### setClaimEnd

Set `claimEnd` configuration

*See `ShadowsLib.packClaimEnd`
See `Solady.Ownable.onlyOwner` modifier for reverts*


```solidity
function setClaimEnd(uint64 value) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint64`|uint64 Claim end timestamp|


### setRoyalties

Set `royalties` configuration

*See `ShadowsLib.packRoyalties`
See `Solady.Ownable.onlyOwner` modifier for reverts
Reverts with `RoyaltiesTooHigh` when royalties `value` > 10%*


```solidity
function setRoyalties(uint16 value) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint16`|uint16 Royalties amount in BPs|


### setPrice

Set `price` configuration

*See `ShadowsLib.packRoyalties`
See `Solady.Ownable.onlyOwner` modifier for reverts
Reverts with `PriceTooHigh` when `value` > 1 ether*


```solidity
function setPrice(uint32 value) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint32`|uint32 Price in gwei|


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
function _startTokenId() internal pure virtual override returns (uint256);
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


## Errors
### AlreadyClaimed
`AlreadyClaimed` error


```solidity
error AlreadyClaimed();
```

### AlreadyRevealed
`AlreadyRevealed` error


```solidity
error AlreadyRevealed();
```

### ClaimPeriodNotFinished
`ClaimPeriodNotFinished` error


```solidity
error ClaimPeriodNotFinished();
```

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

### NotShadowOwner
`NotShadowOwner` error


```solidity
error NotShadowOwner();
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

### PublicMintNotStartedYet
`PublicMintNotStartedYet` error


```solidity
error PublicMintNotStartedYet();
```

### PublicMintStarted
`PublicMintStarted` error


```solidity
error PublicMintStarted();
```

### PriceTooHigh
`PriceTooHigh` error


```solidity
error PriceTooHigh();
```

### RoyaltiesTooHigh
`RoyaltiesTooHigh` error


```solidity
error RoyaltiesTooHigh();
```

### ZeroQuantity
`ZeroQuantity` error


```solidity
error ZeroQuantity();
```

