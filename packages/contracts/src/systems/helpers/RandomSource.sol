// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./IRandomSource.sol";

contract RandomSource is IRandomSource {
  mapping(uint256 => bytes32) public randomSeeds;
  // maximum number of blocks to retreat on this chain
  uint256 blockhashRetreat;

  constructor(uint256 _blockhashRetreat) {
    blockhashRetreat = _blockhashRetreat;
  }

  function commitBlock() public {
    if (randomSeeds[block.number - 1] == 0) {
      randomSeeds[block.number - 1] = blockhash(block.number - 1);
    }
  }

  // return 0 if blockhash is not available
  function getRandomSeed(uint blockNumber) public view returns (uint256) {
    require(blockNumber < block.number, "RandomSource::blockNumber must be less than current block number");
    bytes32 randomSeed;
    if (block.number - blockNumber > blockhashRetreat) {
      if (randomSeeds[blockNumber] != 0) {
        randomSeed = randomSeeds[blockNumber];
      } else {
        return 0;
      }
    } else {
      randomSeed = blockhash(blockNumber);
    }
    return uint256(randomSeed);
  }
}
