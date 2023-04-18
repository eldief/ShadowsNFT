# ShadowsLib
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\libraries\ShadowsLib.sol)

**Author:**
@eldief

Library to pack / unpack `Shadows._tokenConfiguration`

*Import constants from `ShadowsMasks` library*


## Functions
### unpackBackground

*Internal function that returns expansion slot 0 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackBackground(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packBackground

*Internal function that set expansion slot 0 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packBackground(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackHead

*Internal function that returns expansion slot 1 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackHead(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packHead

*Internal function that set expansion slot 1 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packHead(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackChest

*Internal function that returns expansion slot 2 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackChest(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packChest

*Internal function that set expansion slot 2 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packChest(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackShoulders

*Internal function that returns expansion slot 3 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackShoulders(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packShoulders

*Internal function that set expansion slot 3 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packShoulders(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackBack

*Internal function that returns expansion slot 4 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackBack(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packBack

*Internal function that set expansion slot 4 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packBack(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackAccessories

*Internal function that returns expansion slot 5 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackAccessories(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packAccessories

*Internal function that set expansion slot 5 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packAccessories(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackHand1

*Internal function that returns expansion slot 6 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackHand1(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packHand1

*Internal function that set expansion slot 6 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packHand1(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackHand2

*Internal function that returns expansion slot 7 data
Unpack `tokenConfiguration` slots*


```solidity
function unpackHand2(uint256 tokenConfiguration) internal pure returns (uint256 expansionId, uint256 itemId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint256`|uint256 Unpacked `expansionId`|
|`itemId`|`uint256`|uint256 Unpacked `itemId`|


### packHand2

*Internal function that set expansion slot 7 data
Pack `tokenConfiguration` slot
Clear and override slot reserved bits*


```solidity
function packHand2(uint256 tokenConfiguration, uint8 expansionId, uint16 itemId)
    internal
    pure
    returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`expansionId`|`uint8`|uint8 Expansion id|
|`itemId`|`uint16`|uint16 Item id|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


### unpackSeed

*Internal function that returns seed
Unpack `tokenConfiguration` slots*


```solidity
function unpackSeed(uint256 tokenConfiguration) internal pure returns (uint256 seed);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`seed`|`uint256`|uint256 Unpacked `seed`|


### packSeed

*Internal function that set 'seed'
Pack `seed` for `tokenConfiguration` slot*


```solidity
function packSeed(uint256 tokenConfiguration, uint64 seed) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`seed`|`uint64`|uint64 Seed|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


