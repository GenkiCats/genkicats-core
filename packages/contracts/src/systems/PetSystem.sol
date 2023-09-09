// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserItems, UserCats, UserStatus } from "../codegen/Tables.sol";
import { CatHobbyStatus, HobbyConfig, HobbyLog, HobbyTierConfig } from "../codegen/Tables.sol";
import { FoodConfig } from "../codegen/Tables.sol";
import { BuffStatus, BuffConfig, ItemBuffConfig } from "../codegen/Tables.sol";
import { AutoFeederStatus, CatAttributes, Cats, CatConfig, CatLevelConfig, CatFriendshipLevelConfig } from "../codegen/Tables.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

import { LibPet } from "./libs/LibPet.sol";
import { LibPrecision } from "./libs/LibPrecision.sol";
import { LibRandom } from "./libs/LibRandom.sol";
//TODO: remove in production
import "forge-std/console.sol";

contract PetSystem is System {
  // always use this function to get the cat's status before any operation
  function getStatus(bytes32 catId) public returns (uint32, uint32) {
    liveUpdate(catId);
    uint32 hunger = Cats.getHunger(catId);
    uint32 fun = Cats.getFun(catId);
    return (hunger, fun);
  }

  function getHunger(bytes32 catId) public returns (uint32) {
    liveUpdate(catId);
    return Cats.getHunger(catId);
  }

  function getFun(bytes32 catId) public returns (uint32) {
    liveUpdate(catId);
    return Cats.getFun(catId);
  }

  function touch(bytes32 catId) public {
    bytes32 userId = getUserId(_msgSender());
    LibPet.checkPetOwner(catId, userId);
    LibPet.checkPetStatus(catId, userId);

    liveUpdate(catId);

    uint32 userLevel = UserStatus.getLevel(userId);
    uint32 funLimit = CatConfig.getFunLimit();
    uint32 fun = Cats.getFun(catId);

    require(fun < funLimit, "The cat is already in the best mood");
    //TODO: if change this formula to table config
    uint32 funAddBase = (userLevel * funLimit * 200) / 10000 + (funLimit * 3000) / 10000;
    console.log("funAddBase", funAddBase);
    // use simple random distrub here
    uint32 funAdd = uint32(
      LibRandom.getSimpleRandDisturbResult(
        uint256(funAddBase),
        uint256(funAddBase) / 4,
        uint256(keccak256(abi.encodePacked(catId, fun, block.timestamp))),
        "funAdd"
      )
    );
    uint32 newFun = fun + funAdd;
    console.log("newFun", newFun);
    // avoid overflow
    if (newFun > funLimit) {
      newFun = funLimit;
    }
    // update fun
    Cats.setFun(catId, newFun);
  }

  /**
   *
   * Notice: we do not judge if the itemId is a food item here.
   *
   */
  function feed(bytes32 catId, bytes32 itemId, uint32 quantity) public {
    bytes32 userId = getUserId(_msgSender());
    LibPet.checkPetOwner(catId, userId);
    LibPet.checkPetStatus(catId, userId);

    IWorld world = getWorld();

    liveUpdate(catId);

    // item consumption
    world.decItem(userId, itemId, quantity);

    uint32 hungerAdd = FoodConfig.get(itemId) * quantity;
    uint32 hunger = Cats.getHunger(catId);
    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 newHunger = hunger + hungerAdd;
    console.log("newHunger", newHunger);
    // avoid overflow
    if (newHunger > hungerLimit) {
      newHunger = hungerLimit;
    }
    // update hunger
    Cats.setHunger(catId, newHunger);

    // update pet buff end time
    bytes32[] memory buffIds = ItemBuffConfig.get(itemId);
    for (uint256 i = 0; i < buffIds.length; i++) {
      uint32 buffType = BuffConfig.getBuffType(buffIds[i]);
      BuffStatus.set(0, catId, buffType, buffIds[i], block.timestamp);
    }
  }

  // call back pets lost temporarily
  function recall(bytes32 catId) public {
    bytes32 userId = getUserId(_msgSender());
    LibPet.checkPetOwner(catId, userId);
    require(UserCats.getStatus(userId, catId) == 3, "The cat has not left");
    UserCats.setStatus(userId, catId, 1);
  }

  function getHobbyHungerConsumption(bytes32 catId) public view returns (uint32) {
    uint32 hobbyConsumption = 0;
    bytes32 hobbyLogId = CatHobbyStatus.getCurrentLogId(catId);

    // skip hobby activity consumption if the cat never did any hobby activity
    if (hobbyLogId > 0) {
      uint256 lastUpdateTime = HobbyLog.getLastUpdateTime(hobbyLogId);
      uint256 consumptionEndTime = HobbyLog.getEndTime(hobbyLogId);
      // assume the block.timestamp is always greater than the hobbyLog's start time
      if (lastUpdateTime < consumptionEndTime && block.timestamp > lastUpdateTime) {
        // Notice each time before we start a new hobby activity, we will invoke this liveUpdate() function
        // so we can ensure the hobbyLogId is the latest one and we will not miss any hobby activity consumption

        // if never calculate the hobby activity consumption, use the hobby activity start time as the lastUpdateTime
        if (lastUpdateTime == 0) {
          lastUpdateTime = HobbyLog.getStartTime(hobbyLogId);
        }
        // if the hobby activity is still in progress, use the block.timestamp as the consumptionEndTime
        if (block.timestamp <= consumptionEndTime) {
          consumptionEndTime = block.timestamp;
        }

        uint256 timeDiff = consumptionEndTime - lastUpdateTime;
        uint32 hobbyConsumptionRate = HobbyConfig.getHungerConsumptionRate(hobbyLogId);
        uint32 hungerLimit = CatLevelConfig.getHungerLimit(Cats.getLevel(catId));
        hobbyConsumption = uint32(
          (uint256(hobbyConsumptionRate) * timeDiff * uint256(hungerLimit)) / LibPrecision.CONSUMPTION_PRECISION
        );
      }
    }
    return hobbyConsumption;
  }

  function updateHobbyHungerConsumption(bytes32 catId) public returns (uint32) {
    uint32 hobbyConsumption = getHobbyHungerConsumption(catId);
    bytes32 hobbyLogId = CatHobbyStatus.getCurrentLogId(catId);
    HobbyLog.setLastUpdateTime(hobbyLogId, block.timestamp);
    return hobbyConsumption;
  }

  function updateStarvingStartTime(bytes32 catId) public {
    uint32 level = Cats.getLevel(catId);
    uint32 hunger = Cats.getHunger(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 hungerConsumeRateBase = CatConfig.getHungerConsumeRate();

    uint256 lastUpdateTime = Cats.getLastUpdateTime(catId);
    uint256 starvingStartTime = Cats.getStarvingTime(catId);

    // if old hunger is not 0, update starving time
    // calculate starving start time, ignroe the hobby activity consumption
    require(hungerConsumeRateBase > 0 && hungerLimit > 0, "invalid hungerConsumeRateBase or hungerLimit");
    uint256 zeroTime = (hunger * 10000) / (hungerConsumeRateBase * hungerLimit);
    starvingStartTime = lastUpdateTime + zeroTime;
    // update starving time
    Cats.setStarvingTime(catId, starvingStartTime);
  }

  function _starvingUpdate(bytes32 catId, uint32 hunger, uint32 newHunger) internal {
    if (newHunger > 0 && hunger == 0) {
      // clean the starving time
      Cats.setStarvingTime(catId, 0);
    }
    if (newHunger == 0 || hunger == 0) {
      starvingCheck(catId);
    }
    if (newHunger == 0 && hunger > 0) {
      updateStarvingStartTime(catId);
    }
  }

  function starvingCheck(bytes32 catId) public {
    uint256 starvingStartTime = Cats.getStarvingTime(catId);
    // check if the cat is starving too long to leave
    // starvingStartTime = 0 means the cat is not starving
    if (starvingStartTime != 0) {
      uint256 starvingDuration = block.timestamp - starvingStartTime;
      bytes32 userId = Cats.getOwnerId(catId);
      uint32 friendshipLevel = UserCats.getFriendshipLevel(userId, catId);
      uint256 starvingTimeLimit = uint256(CatFriendshipLevelConfig.getStarvingTimeLimit(friendshipLevel));
      uint256 starvingStartTime = CatConfig.getStarvingStartTime();

      // cat has chance to leave each day if it has been starving for a long time
      if (starvingDuration > starvingStartTime) {
        // use simple random here, each day the cat has a fix chance to leave if invoke this function
        uint256 randSeed = uint256(keccak256(abi.encodePacked((block.timestamp) % 86400, catId)));
        if (starvingTimeLimit == 0) {
          LibPet.lost(catId, friendshipLevel);
        } else {
          uint256 rand = randSeed % starvingTimeLimit;
          // assume starvingStartTime is less than starvingTimeLimit, this can be ensured by init game designer
          if (rand > starvingDuration) {
            LibPet.lost(catId, friendshipLevel);
          }
        }
      }

      // if the cat is starving too long, it will leave
      if (starvingDuration >= starvingTimeLimit) {
        LibPet.lost(catId, friendshipLevel);
        return;
      }
    }
  }

  function calculateBasicHungerConsumption(bytes32 catId, uint256 timeDiff) public view returns (uint32) {
    // calculate new status
    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 hungerConsumeRateBase = CatConfig.getHungerConsumeRate();
    // calculate the basic hunger consumption
    uint32 hungerConsumption = uint32(
      (uint256(hungerConsumeRateBase) * uint(hungerLimit) * timeDiff) / LibPrecision.CONSUMPTION_PRECISION
    );
    return hungerConsumption;
  }

  function calculateBasicFunConsumption(bytes32 catId, uint256 timeDiff) public view returns (uint32) {
    // get cat status
    uint32 fun = Cats.getFun(catId);
    uint32 funLimit = CatConfig.getFunLimit();

    uint32 funConsumeRate = CatConfig.getFunConsumeRate();
    uint32 funConsumption = uint32(
      (uint256(funConsumeRate) * uint256(funLimit) * timeDiff) / LibPrecision.CONSUMPTION_PRECISION
    );
    return funConsumption;
  }

  function estimateCatStatus(bytes32 catId) public view returns (uint32, uint32) {
    uint256 timeDiff = block.timestamp - Cats.getLastUpdateTime(catId);
    bytes32 userId = Cats.getOwnerId(catId);
    // if the cat is lost, return (0, 0)
    if (UserCats.getStatus(userId, catId) > 2) {
      return (0, 0);
    }
    uint32 hungerConsumption = calculateBasicHungerConsumption(catId, timeDiff) + getHobbyHungerConsumption(catId);
    uint32 funConsumption = calculateBasicFunConsumption(catId, timeDiff);

    // get cat status
    uint32 fun = Cats.getFun(catId);
    uint32 hunger = Cats.getHunger(catId);
    uint32 newHunger = hungerConsumption > hunger ? 0 : hunger - hungerConsumption;
    uint32 newFun = funConsumption > fun ? 0 : fun - funConsumption;
    // @AutoFeederSystem
    (newHunger, ) = getWorld().calculateAutoFeed(newHunger, userId, catId);
    return (newHunger, newFun);
  }

  // anyone can call this function to update the cat's status
  // this function must be called each time before the cat's hunger and fun status is read
  function liveUpdate(bytes32 catId) public {
    console.log("liveUpdate, catId: %s", uint256(catId));
    console.log("catHunger before liveupdate: %s", uint256(Cats.getHunger(catId)));
    console.log("catFun before liveupdate: %s", uint256(Cats.getFun(catId)));

    // check if can live update
    uint256 lastUpdateTime = Cats.getLastUpdateTime(catId);
    if (lastUpdateTime == 0) {
      // init update
      Cats.setLastUpdateTime(catId, block.timestamp);
      return;
    }
    console.log("catId: %s, lastUpdateTime: %s, blockTime: %s", uint256(catId), lastUpdateTime, block.timestamp);
    uint256 timeDiff = block.timestamp - lastUpdateTime;
    if (timeDiff == 0) {
      console.log("timeDiff is 0, no need to update");
      return;
    }

    console.log("liveUpdate, catId: %s, timeDiff: %s", uint256(catId), timeDiff);

    // get basic cat status
    bytes32 userId = Cats.getOwnerId(catId);
    uint8 status = UserCats.getStatus(userId, catId);
    // if the cat is lost, do nothing
    if (status > 2) {
      return;
    }
    // update hobby hunger consumption
    uint32 hobbyHungerConsumption = updateHobbyHungerConsumption(catId);
    console.log("hobbyHungerConsumption: %s", hobbyHungerConsumption);

    // get cat status
    uint32 fun = Cats.getFun(catId);
    uint32 hunger = Cats.getHunger(catId);

    // calculate the basic hunger consumption
    uint32 hungerConsumption = calculateBasicHungerConsumption(catId, timeDiff);
    console.log("hungerBasicConsumption: %s", hungerConsumption);
    // add the hobby activity consumption to get the total hunger consumption
    hungerConsumption += hobbyHungerConsumption;
    uint32 funConsumption = calculateBasicFunConsumption(catId, timeDiff);
    console.log("funBasicConsumption: %s", funConsumption);
    uint32 newHunger;
    if (hungerConsumption >= hunger) {
      newHunger = 0;
    } else {
      newHunger = hunger - hungerConsumption;
    }
    uint32 newFun;
    if (funConsumption >= fun) {
      newFun = 0;
    } else {
      newFun = fun - funConsumption;
    }

    _starvingUpdate(catId, hunger, newHunger);
    console.log("starving updated");

    // update status
    Cats.setHunger(catId, newHunger);
    Cats.setFun(catId, newFun);

    // autoFeeder feed udpate
    // @AutoFeederSystem
    getWorld().autoFeed(catId);

    console.log("auto feeder feed updated");

    Cats.setLastUpdateTime(catId, block.timestamp);

    console.log("catHunger after liveupdate: %s", uint256(Cats.getHunger(catId)));
    console.log("catFun after liveupdate: %s", uint256(Cats.getFun(catId)));
  }
}
