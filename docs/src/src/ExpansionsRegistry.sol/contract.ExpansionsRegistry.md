# ExpansionsRegistry
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\ExpansionsRegistry.sol)

**Inherits:**
Ownable

**Author:**
@eldief

Contract for registering `Expansions` addresses

*Uses `Solady.Ownable` for ownership*


## State Variables
### expansions
Expansion addresses

*Public mapping from `expansionId` to `expansion` address*


```solidity
mapping(uint256 => address) public expansions;
```


## Functions
### constructor

Constructor

*Initialize ownership via `Solady.Ownable`*


```solidity
constructor();
```

### registerExpansion

Register an expansion

*If `expansion` is `address(0)`, `expansionId` is unregistered
See `Solady.Ownable.onlyOwner` modifier for reverts`
Emit `ExpansionSet` event*


```solidity
function registerExpansion(uint8 expansionId, address expansion) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`expansionId`|`uint8`|uint8 Expansion id|
|`expansion`|`address`|address Expansion address|


## Events
### ExpansionSet
`ExpansionSet` event


```solidity
event ExpansionSet(uint8 indexed expansionId, address expansion);
```

