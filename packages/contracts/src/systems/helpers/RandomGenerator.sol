// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./IRandomSource.sol";

contract RandomGenerator {
  IRandomSource public randomSource;

  struct RandomReqeust {
    uint256 blockNumber;
    uint256 delayBlocks;
  }

  constructor(address randomSourceAddress) {
    randomSource = IRandomSource(randomSourceAddress);
  }

  mapping(uint256 => mapping(uint256 => uint256)) public randomSeeds;
  mapping(bytes32 => RandomReqeust) public randomRequests;

  function requestRandom() public view returns (uint256) {
    return block.number;
  }

  function requestRandom(uint256 delayBlocks) public view returns (bytes32) {
    return keccak256(abi.encodePacked(block.number, delayBlocks));
  }

  function requestRandomWithCommit() public returns (uint256) {
    randomSource.commitBlock();
    return block.number;
  }

  function requestRandomWithCommit(uint256 delayBlocks) public returns (bytes32) {
    randomSource.commitBlock();
    return keccak256(abi.encodePacked(block.number, delayBlocks));
  }

  function getRandom(uint256 blockNumber, uint256 delayBlocks) public view returns (uint256) {
    return randomSource.getRandomSeed(blockNumber + delayBlocks);
  }

  function getRandom(bytes32 requestId) public view returns (uint256) {
    uint256 blockNumber = randomRequests[requestId].blockNumber;
    uint256 delayBlocks = randomRequests[requestId].delayBlocks;
    return randomSource.getRandomSeed(blockNumber + delayBlocks);
  }

  function getRandomWithSave(uint256 blockNumber, uint256 delayBlocks) public returns (uint256) {
    if (randomSeeds[blockNumber][delayBlocks] == 0) {
      randomSeeds[blockNumber][delayBlocks] = randomSource.getRandomSeed(blockNumber + delayBlocks);
    }
    return randomSeeds[blockNumber][delayBlocks];
  }

  function getRandomWithSave(bytes32 requestId) public returns (uint256) {
    uint256 blockNumber = randomRequests[requestId].blockNumber;
    uint256 delayBlocks = randomRequests[requestId].delayBlocks;
    if (randomSeeds[blockNumber][delayBlocks] == 0) {
      randomSeeds[blockNumber][delayBlocks] = randomSource.getRandomSeed(blockNumber + delayBlocks);
    }
    return randomSeeds[blockNumber][delayBlocks];
  }
}
