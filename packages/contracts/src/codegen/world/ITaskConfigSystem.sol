// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface ITaskConfigSystem {
  function setupTasks(
    bytes32[] memory taskIds,
    uint32[] memory levels,
    uint32[] memory dupPeriods,
    uint32[] memory rewardExps,
    uint256[] memory rewardCoins,
    uint256[] memory rewardDiamonds,
    string[] memory names,
    string[] memory uris
  ) external;

  function activeTasks(bytes32[] memory taskIds) external;

  function setTask(
    bytes32 taskId,
    uint32 level,
    uint32 dupPeriod,
    uint32 rewardExp,
    uint256 rewardCoins,
    uint256 rewardDiamonds,
    uint8 status,
    string memory name,
    string memory uri
  ) external;

  function setTaskRequirement(
    bytes32 taskId,
    bytes32[] memory requiredTaskIds,
    bytes32[] memory itemIds,
    uint32[] memory itemQuantities,
    bool[] memory itemConsumed
  ) external;

  function setTaskReward(bytes32 taskId, bytes32[] memory itemIds, uint32[] memory itemQuantities) external;
}
