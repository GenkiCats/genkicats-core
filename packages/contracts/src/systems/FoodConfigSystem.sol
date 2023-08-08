// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { FoodConfig, ItemConfig, MetaConfig, ItemBuffEffectConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract FoodConfigSystem is System {
  function setFood(
    bytes32 itemId,
    uint32 hunger,
    uint32 dropRate,
    uint32 maxItemQuantity,
    uint32 hungerCoinRate,
    string memory name,
    string memory uri
  ) public {
    FoodConfig.set(itemId, hunger, dropRate, hungerCoinRate);
    ItemConfig.set(itemId, maxItemQuantity, address(0));
    MetaConfig.set(itemId, name, uri);
  }
}
