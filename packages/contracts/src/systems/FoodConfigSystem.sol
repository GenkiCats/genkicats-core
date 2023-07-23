// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { FoodConfig, ItemConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract FoodConfigSystem is System {
  function setFood(
    uint itemId,
    uint32 hunger,
    uint32 travelDropRate,
    uint32 maxItemQuantity,
    string memory name,
    string memory uri
  ) public {
    FoodConfig.set(itemId, hunger, travelDropRate);
    ItemConfig.set(itemId, maxItemQuantity, name, uri);
  }
}
