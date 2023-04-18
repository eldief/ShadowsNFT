# IERC2981
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\interfaces\IERC2981.sol)

*Interface for the NFT Royalty Standard*


## Functions
### royaltyInfo

ERC165 bytes to add to interface array - set in parent contract
implementing this standard
bytes4(keccak256("royaltyInfo(uint256,uint256)")) == 0x2a55205a
bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;
_registerInterface(_INTERFACE_ID_ERC2981);

Called with the sale price to determine how much royalty


```solidity
function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
    external
    view
    returns (address receiver, uint256 royaltyAmount);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_tokenId`|`uint256`|- the NFT asset queried for royalty information|
|`_salePrice`|`uint256`|- the sale price of the NFT asset specified by _tokenId|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`receiver`|`address`|- address of who should be sent the royalty payment|
|`royaltyAmount`|`uint256`|- the royalty payment amount for _salePrice|


