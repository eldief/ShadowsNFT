# ShadowsRenderer
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\ShadowsRenderer.sol)

**Author:**
@eldief

Renderer contact for `Shadows`

*Uses `Solady.LibString` for string manipulation
Uses `ShadowsLib` for packing / unpacking
Uses `Solady.DynamicBufferLib` for bytes concatenation*


## State Variables
### _DESCRIPTION
Constant contract `description`


```solidity
bytes internal constant _DESCRIPTION = "";
```


### registry
`ExpansionsRegistry` immutable contract reference


```solidity
ExpansionsRegistry public immutable registry;
```


## Functions
### constructor

Constructor

*Register `ExpansionsRegistry` immutable reference*


```solidity
constructor(address _registry);
```

### render

Render `Shadows.tokenURI`

*On-chain render for `Shadows` NFT
Buffers are instanciated here and passed by reference to internal functions
Render both `Shadows` metadata and valid `Expansions` metadata*


```solidity
function render(address tokenOwner, uint256 tokenId, uint256 tokenConfiguration)
    external
    view
    returns (string memory tokenURI);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenOwner`|`address`|address Rendering token owner|
|`tokenId`|`uint256`|uint256 Token id|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration`|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`tokenURI`|`string`|On-chain svg Base64 encoded|


### _renderBase

Render `Shadows` metadata

*Internal function that renders this token
Buffers are passed by reference to save gas while appending data*


```solidity
function _renderBase(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    uint256 tokenConfiguration
) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`attributesBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for attributes metadata|
|`imageBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for image metadata|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration`|


### _renderExpansions

Render `Expansions` metadata

*Internal function that renders each equipment slot
Buffers are passed by reference to save gas while appending data*


```solidity
function _renderExpansions(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    address tokenOwner,
    uint256 tokenConfiguration
) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`attributesBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for attributes metadata|
|`imageBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for image metadata|
|`tokenOwner`|`address`|address Rendering token owner|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration`|


### _renderExpansion

Render an `Expansion` metadata

*Internal function that renders an equipment slot
Buffers are passed by reference to save gas while appending data
Checking equipment validity is delegated to this view function to save gas on setters
Because of this, a try-catch block is needed to prevent reverting `tokenURI` function
Read from `ExpansionsRegistry` the address link to `expansionId`
Skip rendering if expansion is invalid, equipment is not owned by `tokenOwner` or `slot` is invalid for `itemId`*


```solidity
function _renderExpansion(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    address tokenOwner,
    uint256 expansionId,
    uint256 itemId,
    uint256 slotId
) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`attributesBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for attributes metadata|
|`imageBuffer`|`DynamicBuffer.DynamicBufferLib`|DynamicBufferLib.DynamicBuffer for image metadata|
|`tokenOwner`|`address`|address Owner of rendered tokenId|
|`expansionId`|`uint256`|uint256 Expansion id|
|`itemId`|`uint256`|uint256 Item id|
|`slotId`|`uint256`|uint256 Slot id|


