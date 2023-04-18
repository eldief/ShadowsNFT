# IERC4906
[Git Source](https://github.com/eldief/ShadowsNFT/blob/7ce67e6bb7c3b90f87e420d23e726e90381733cb/src\interfaces\IERC4906.sol)


## Events
### MetadataUpdate
*This event emits when the metadata of a token is changed.
So that the third-party platforms such as NFT market could
timely update the images and related attributes of the NFT.*


```solidity
event MetadataUpdate(uint256 _tokenId);
```

### BatchMetadataUpdate
*This event emits when the metadata of a range of tokens is changed.
So that the third-party platforms such as NFT market could
timely update the images and related attributes of the NFTs.*


```solidity
event BatchMetadataUpdate(uint256 _fromTokenId, uint256 _toTokenId);
```

