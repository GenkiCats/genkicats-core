// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IHobbyOpenConfigSystem {
  function setupHobbyConfig(
    string memory hobbyName,
    string memory uri,
    uint8 playerChosenTagNum,
    uint32 hungerConsumptionRate,
    uint8 extraRewardNum,
    bool hasExtraSteps,
    bytes32 hobbyAttractiveItem,
    bytes32[] memory requiredItems,
    uint32 delayBlocks,
    bool strictRandom
  ) external;

  function setupHobbyTierTimes(
    bytes32 hobbyId,
    uint8[] memory tiers,
    uint256[] memory baseTimes,
    uint256[] memory baseRestTimes
  ) external;

  function setHobbyTierTime(bytes32 hobbyId, uint8 tier, uint256 baseTime, uint256 baseRestTime) external;

  function setHobbyTierChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    uint8[] memory tierChosenRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) external;

  function setHobbyTierChosenSampleIds(bytes32 hobbyId, uint8[] calldata tiers, bytes32[] calldata sampleIds) external;

  function setHobbyTierChosenRange(bytes32 hobbyId, uint8 tier, uint8[] calldata tierChosenRange) external;

  function setHobbyLevelTierConfig(bytes32 hobbyId, uint8[] calldata tiers) external;

  function setHobbyTagChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    bytes32[] memory tagChosenRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) external;

  function setHobbyTagChosenRange(bytes32 hobbyId, uint8 tier, bytes32[] calldata tagChosenRange) external;

  function setHobbyTagChosenSampleIds(bytes32 hobbyId, uint8[] calldata tiers, bytes32[] calldata sampleIds) external;

  function setHobbyRewardItems(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32[] calldata itemIds) external;

  function setHobbyRewardSampleId(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32 sampleId) external;

  function setupHobbyRewardItemChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    bytes32 sampleId,
    uint8 samplingMethod,
    bytes32[] memory itemIds,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) external;

  function setHobbySteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32[] calldata extraSteps) external;

  function addHobbyRewardSteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32 extraStep) external;

  function setHobbyExtraReward(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint8 extraIndex,
    bytes32[] calldata itemIds
  ) external;

  function addHobbyExtraReward(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint8 extraIndex, bytes32 itemId) external;
}
