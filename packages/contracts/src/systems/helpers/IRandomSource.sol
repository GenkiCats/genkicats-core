// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IRandomSource {
  function commitBlock() external;

  function getRandomSeed(uint blockNumber) external view returns (uint256);
}
