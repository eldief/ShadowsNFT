# ExpansionsLib
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\libraries\ExpansionsLib.sol)

**Author:**
@eldief

Library to pack / unpack `ExpansionBase._configuration` and `ExpansionBase._tokenConfiguration`

*Import constants from `ExpansionMasks` library*


## Functions
### unpackSalt

*Internal function that returns `salt`
Unpack `salt` from `configuration`*


```solidity
function unpackSalt(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `salt`|


### packSalt

*Internal function that set `salt`
Pack `configuration` slot
Do not clear slot since `salt` can only be set once*


```solidity
function packSalt(uint256 configuration, uint64 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint64`|uint64 Salt|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackClaimEnd

*Internal function that returns `claim end`
Unpack `claim end` from `configuration`*


```solidity
function unpackClaimEnd(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `claim end`|


### packClaimEnd

*Internal function that set `claim end`
Pack `configuration` slot
Clear and override slot reserved bits*


```solidity
function packClaimEnd(uint256 configuration, uint64 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint64`|uint64 Claim end|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackRoyalties

*Internal function that returns `royalties`
Unpack `royalties` from `configuration`*


```solidity
function unpackRoyalties(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `royalties`|


### packRoyalties

*Internal function that set `royalties`
Pack `configuration` slot
Clear and override slot reserved bits*


```solidity
function packRoyalties(uint256 configuration, uint16 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint16`|uint16 Royalties in BPs|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackMaxQuantity

*Internal function that returns `max quantity`
Unpack `max quantity` from `configuration`*


```solidity
function unpackMaxQuantity(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `max quantity`|


### packMaxQuantity

*Internal function that set `max quantity`
Pack `configuration` slot
Clear and override slot reserved bits*


```solidity
function packMaxQuantity(uint256 configuration, uint8 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint8`|uint8 Max quantity|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackMaxTotalSupply

*Internal function that returns `total supply`
Unpack `total supply` from `configuration`*


```solidity
function unpackMaxTotalSupply(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `total supply`|


### packMaxTotalSupply

*Internal function that set `maxTotalSupply`
Pack `configuration` slot
Clear and override slot reserved bits*


```solidity
function packMaxTotalSupply(uint256 configuration, uint16 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint16`|uint16 Total max supply|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackPrice

*Internal function that returns `price`
Unpack `price` from `configuration`*


```solidity
function unpackPrice(uint256 configuration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `price`|


### packPrice

*Internal function that set `price`
Pack `configuration` slot
Clear and override slot reserved bits*


```solidity
function packPrice(uint256 configuration, uint32 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`configuration`|`uint256`|uint256 Packed `configuration` data|
|`value`|`uint32`|uint32 Price in gwei|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `configuration` param|


### unpackSeed

*Internal function that returns `seed`
Unpack `seed` from `tokenConfiguration`*


```solidity
function unpackSeed(uint256 tokenConfiguration) internal pure returns (uint256 value);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`value`|`uint256`|uint256 Unpacked `seed`|


### packSeed

*Internal function that set `seed`
Pack `tokenConfiguration` slot
Do not clear slot since `seed` can only be set once*


```solidity
function packSeed(uint256 tokenConfiguration, uint64 value) internal pure returns (uint256 result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenConfiguration`|`uint256`|uint256 Packed `tokenConfiguration` data|
|`value`|`uint64`|uint64 seed|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`uint256`|uint256 Modified `tokenConfiguration` param|


