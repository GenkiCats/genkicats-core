// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IHobbyHelperSystem {
  function getHobbyLevelTierConfig(bytes32 hobbyId, uint32 level) external view returns (uint8);

  function getHobbyTierChosenSampleId(bytes32 hobbyId, uint32 level) external view returns (bytes32);

  function getHobbyTagChosenSampleId(bytes32 hobbyId, uint8 tier) external view returns (bytes32);

  function getHobbyTierBySeed(bytes32 hobbyId, bytes32 catId, uint256 randSeed) external view returns (uint8);

  function getHobbyTagBySeed(bytes32 hobbyId, uint8 tier, uint256 randSeed) external view returns (bytes32);

  function getHobbyTagsBySeed(
    bytes32 hobbyId,
    uint8 tier,
    uint256 randSeed,
    uint32 tagNum
  ) external view returns (bytes32[] memory);

  function getHobbyRewardItemIndexBySeed(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) external view returns (uint256);

  function getHobbyRewardItemsBySeed(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) external view returns (bytes32[] memory);
}
