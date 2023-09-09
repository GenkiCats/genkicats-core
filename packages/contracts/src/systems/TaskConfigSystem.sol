// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { TaskConfig, TaskRequiredItemsConfig, TaskRequiredTasksConfig, TaskRewardItemsConfig, MetaConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

// non open system
contract TaskConfigSystem is System {
  function setupTasks(
    bytes32[] memory taskIds,
    uint32[] memory levels,
    uint32[] memory dupPeriods,
    uint32[] memory rewardExps,
    uint256[] memory rewardCoins,
    uint256[] memory rewardDiamonds,
    string[] memory names,
    string[] memory uris
  ) public {
    for (uint i = 0; i < taskIds.length; i++) {
      setTask(
        taskIds[i],
        levels[i],
        dupPeriods[i],
        rewardExps[i],
        rewardCoins[i],
        rewardDiamonds[i],
        0,
        names[i],
        uris[i]
      );
    }
  }

  function activeTasks(bytes32[] memory taskIds) public {
    for (uint i = 0; i < taskIds.length; i++) {
      TaskConfig.setStatus(taskIds[i], 1);
    }
  }

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
  ) public {
    TaskConfig.set(taskId, level, dupPeriod, rewardExp, rewardCoins, rewardDiamonds, status);
    MetaConfig.set(taskId, name, uri);
  }

  function setTaskRequirement(
    bytes32 taskId,
    bytes32[] memory requiredTaskIds,
    bytes32[] memory itemIds,
    uint32[] memory itemQuantities,
    bool[] memory itemConsumed
  ) public {
    TaskRequiredTasksConfig.set(taskId, requiredTaskIds);
    TaskRequiredItemsConfig.set(taskId, itemIds, itemQuantities, itemConsumed);
  }

  function setTaskReward(bytes32 taskId, bytes32[] memory itemIds, uint32[] memory itemQuantities) public {
    TaskRewardItemsConfig.set(taskId, itemIds, itemQuantities);
  }
}
