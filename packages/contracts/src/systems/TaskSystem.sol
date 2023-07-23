// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { getSimpleRandomInt } from "./helpers/RandomHelper.sol";
import { UserStatus, UserItems, TaskConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract TaskSystem is System {
  function finishTask(uint256 taskID) public {
    bytes32 userId = getUserId(_msgSender());
    IWorld world = getWorld();

    uint32 requiredLevel = TaskConfig.getLevel(taskID);
    uint32 exp = UserStatus.getExp(userId);
    uint32 level = world.calculateUserLevel(exp);
    require(level >= requiredLevel, "level is not enough");

    //TODO: dup detect
    // uint32 dupPeriod = TaskConfig.getDupPeriod(taskID);

    uint256[] memory itemIds = TaskConfig.getItemIds(taskID);
    uint32[] memory itemQuantities = TaskConfig.getItemQuantities(taskID);
    for (uint256 i = 0; i < itemIds.length; i++) {
      uint256 itemId = itemIds[i];
      // TODO: consider item status
      uint32 itemNum = UserItems.getItemNum(userId, itemId);
      require(itemNum >= itemQuantities[i], "Task required item is not enough");
    }

    // pass the task requirements
    // claim reward items
    uint256[] memory rewardItemIds = TaskConfig.getRewardItemIds(taskID);
    uint32[] memory rewardItemQuantities = TaskConfig.getRewardItemQuantities(taskID);
    for (uint256 i = 0; i < rewardItemIds.length; i++) {
      uint256 itemId = rewardItemIds[i];
      // @QuantityHelperSystem
      world.addItem(userId, itemId, rewardItemQuantities[i]);
    }

    uint32 rewardExp = TaskConfig.getRewardExp(taskID);
    if (rewardExp > 0) {
      world.addExp(userId, rewardExp);
    }
    uint256 rewardCoins = TaskConfig.getRewardCoins(taskID);
    if (rewardCoins > 0) {
      world.addCoin(userId, rewardCoins);
    }
    uint256 rewardDiamonds = TaskConfig.getRewardDiamonds(taskID);
    if (rewardDiamonds > 0) {
      world.addDiamond(userId, rewardDiamonds);
    }
  }

  // small tasks like pick up garbages
  function chores() public {
    bytes32 userId = getUserId(_msgSender());
    IWorld world = getWorld();

    world.addCoin(userId, uint32(getSimpleRandomInt(20)));

    bytes32 eventId = keccak256(abi.encode("chores"));
    world.finishDailyEvents(userId, eventId, 1, 5);
  }
}
