// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Cats, UserItems, UserCats, UserCatList, UserAdoptions, CatConfig, FoodConfig } from "../codegen/Tables.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { getSimpleRandomInt, getSimpleRandomBool } from "./helpers/RandomHelper.sol";

contract CatSystem is System {
  function adoptInitCat() public {
    bytes32 userId = getUserId(_msgSender());

    // adoption number check
    uint32 adoptionNum = UserAdoptions.get(userId);
    require(adoptionNum == 0, "You have already adopted the first cat");
    UserAdoptions.set(userId, 1);

    bytes32 catId = getUniqueEntity();

    UserCats.setObtainTime(userId, catId, block.timestamp);
    UserCats.setStatus(userId, catId, 1);
    UserCatList.push(userId, catId);
    /**
     * Attributes Generation
     *
     */
    bool sex = getSimpleRandomBool();
    uint256 personality = getSimpleRandomInt(1000000000);
    uint256 skin = getSimpleRandomInt(12);
    uint32 hunger = 50;
    uint32 fun = 50;
    uint32 health = 200;
    uint8 cleanLevel = 5;
    uint256 birthTime = block.timestamp;

    Cats.set(catId, sex, 0, 0, personality, skin, 0, 1, hunger, fun, health, cleanLevel, birthTime);
  }

  /**
   *
   * Notice: we do not judge if the itemId is a food item here.
   *
   */
  function feed(bytes32 catId, uint256 itemId, uint32 quantity) public {
    bytes32 userId = getUserId(_msgSender());
    IWorld world = getWorld();
    require(UserCats.getStatus(userId, catId) == 1, "The cat is not here");
    // item consumption
    world.decItem(userId, itemId, quantity);

    uint32 hungerAdd = FoodConfig.getHunger(itemId) * quantity;
    uint32 hunger = Cats.getHunger(catId);
    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatConfig.getHungerLimit(level);
    uint32 newHunger = hunger + hungerAdd;
    // avoid overflow
    if (newHunger > hungerLimit) {
      newHunger = hungerLimit;
    }
    // update hunger
    Cats.setHunger(catId, newHunger);
  }
}
