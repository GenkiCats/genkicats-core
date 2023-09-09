// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { FoodConfig, ItemConfig, MetaConfig, ItemBuffConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";
import { getWorld } from "./helpers/WorldHelper.sol";

contract FoodConfigSystem is System {
  function setupFoods(
    bytes32[] memory itemIds,
    uint32[] memory hungers,
    string[] memory names,
    string[] memory uris
  ) public {
    for (uint i = 0; i < itemIds.length; i++) {
      setFood(itemIds[i], hungers[i], new bytes32[](0), names[i], uris[i]);
    }
  }

  // set same buffs for all input food
  function setupFoodBuffs(bytes32[] memory itemIds, bytes32[] memory buffIds) public {
    for (uint i = 0; i < itemIds.length; i++) {
      ItemBuffConfig.set(itemIds[i], buffIds);
    }
  }

  function setFood(
    bytes32 itemId,
    uint32 hunger,
    bytes32[] memory buffIds,
    string memory name,
    string memory uri
  ) public {
    // avoid potential out of gas
    require(buffIds.length <= 8, "Buffs length must <= 8");
    FoodConfig.set(itemId, hunger);
    for (uint i = 0; i < buffIds.length; i++) {
      ItemBuffConfig.push(itemId, buffIds[i]);
    }
    getWorld().setItem(itemId, name, uri);
  }

  function setFoodBuffs(bytes32 itemId, bytes32[] memory buffIds) public {
    ItemBuffConfig.set(itemId, buffIds);
  }

  function addBatchFoodBuff(bytes32[] memory itemIds, bytes32[] memory buffIds) public {
    for (uint i = 0; i < itemIds.length; i++) {
      ItemBuffConfig.push(itemIds[i], buffIds[i]);
    }
  }
}
