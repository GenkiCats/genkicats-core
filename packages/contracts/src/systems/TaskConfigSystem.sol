// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { TaskConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract TaskConfigSystem is System {
  function setTask(
    uint taskId,
    uint32 level,
    uint32 dupPeriod,
    uint32 rewardExp,
    uint256 rewardCoins,
    uint256 rewardDiamonds,
    bool itemConsumed,
    uint256[] memory itemIds,
    uint32[] memory itemQuantities,
    uint256[] memory rewardItemIds,
    uint32[] memory rewardItemQuantities,
    string memory uri
  ) public {
    if (level > 0) {
      TaskConfig.setLevel(taskId, level);
    }
    if (dupPeriod > 0) {
      TaskConfig.setDupPeriod(taskId, dupPeriod);
    }
    if (rewardExp > 0) {
      TaskConfig.setRewardExp(taskId, rewardExp);
    }
    if (rewardCoins > 0) {
      TaskConfig.setRewardCoins(taskId, rewardCoins);
    }
    if (rewardDiamonds > 0) {
      TaskConfig.setRewardDiamonds(taskId, rewardDiamonds);
    }
    if (itemConsumed == true) {
      TaskConfig.setItemConsumed(taskId, itemConsumed);
    }
    if (itemIds.length > 0) {
      TaskConfig.setItemIds(taskId, itemIds);
    }
    if (itemQuantities.length > 0) {
      TaskConfig.setItemQuantities(taskId, itemQuantities);
    }
    if (rewardItemIds.length > 0) {
      TaskConfig.setRewardItemIds(taskId, rewardItemIds);
    }
    if (rewardItemQuantities.length > 0) {
      TaskConfig.setRewardItemQuantities(taskId, rewardItemQuantities);
    }
    if (bytes(uri).length > 0) {
      TaskConfig.setUri(taskId, uri);
    }
  }
}
