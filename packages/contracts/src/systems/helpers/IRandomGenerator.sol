// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IRandomGenerator {
  function getRandom(uint256 blockNumber, uint256 delayBlocks) external view returns (uint256);
}
