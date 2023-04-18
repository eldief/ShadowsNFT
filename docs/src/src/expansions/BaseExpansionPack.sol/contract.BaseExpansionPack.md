# BaseExpansionPack
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\expansions\BaseExpansionPack.sol)

**Inherits:**
[ExpansionBase](/src\expansions\ExpansionBase.sol\contract.ExpansionBase.md)

**Author:**
@eldief

Shadows NFT first expansion pack

*Inherit shared functionalities from `ExpansionBase`
Customize configuration and rendering*


## Functions
### constructor

Constructor

*Initialize `configuration` packing data
See `ExpansionBase.constructor` for nested initialization
See `ExpansionBase._configuration` for packed layout
See `ExpansionsLib` for pack information*


```solidity
constructor(address shadows_) ExpansionBase(shadows_, "Shadows - Base Expansion Pack", "SHDWS_BASE_EXP");
```

### _renderUnrevealed

Render unrevealed `Shadows - Base Expansion Pack` token

*See `ExpansionBase._renderUnrevealed`*


```solidity
function _renderUnrevealed(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    uint256 seed,
    uint256 tokenId
) internal view override returns (uint256);
```

### _renderRevealed

Render revealed `Shadows - Base Expansion Pack` token

*See `ExpansionBase._renderRevealed`*


```solidity
function _renderRevealed(
    DynamicBufferLib.DynamicBuffer memory attributesBuffer,
    DynamicBufferLib.DynamicBuffer memory imageBuffer,
    uint256 seed,
    uint256 tokenId
) internal view override returns (uint256 slotId);
```

