// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserItems, UserCats, UserCatList, UserAdoptions } from "../codegen/Tables.sol";
import { CatHobbyStatus, HobbyLog, HobbyTierConfig } from "../codegen/Tables.sol";
import { FoodConfig } from "../codegen/Tables.sol";
import { AutoFeeder, AutoFeederConfig } from "../codegen/Tables.sol";
import { CatAutoFeederStatus, CatAttributes, Cats, CatConfig, CatLevelConfig, CatFriendshipLevelConfig } from "../codegen/Tables.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { getSimpleRandomInt, getSimpleRandomBool } from "./helpers/RandomHelper.sol";

contract CatSystem is System {
  function afterAddCat(bytes32 catId) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    totalHungerLimit += hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);

    for (uint256 i = 0; i < catIds.length; i++) {
      uint32 catLevel = Cats.getLevel(catIds[i]);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      CatAutoFeederStatus.setAutoFeedRatio(catIds[i], rate);
    }
  }

  function beforeRemoveCat(bytes32 catId) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    totalHungerLimit -= hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);
    // clean the current auto feed rate
    CatAutoFeederStatus.setAutoFeedRatio(catId, 0);
    // clean the last auto feed time
    CatAutoFeederStatus.setLastAutoFeedTime(catId, 0);

    for (uint256 i = 0; i < catIds.length; i++) {
      bytes32 curCatId = catIds[i];
      // not update the cat which is going to be removed
      if (curCatId == catId) {
        continue;
      }
      uint32 catLevel = Cats.getLevel(curCatId);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      CatAutoFeederStatus.setAutoFeedRatio(curCatId, rate);
    }

    /**
     * Abort active hobby
     */
    uint8 status = HobbyLog.getStatus(catId);
    if (status != 3) {
      HobbyLog.setStatus(catId, 4);
    }
  }

  function afterCatHungerLimitUpdate(bytes32 catId, uint32 oldHungerLimit) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    totalHungerLimit = totalHungerLimit - oldHungerLimit;
    totalHungerLimit = totalHungerLimit + hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);

    for (uint256 i = 0; i < catIds.length; i++) {
      uint32 catLevel = Cats.getLevel(catIds[i]);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      CatAutoFeederStatus.setAutoFeedRatio(catIds[i], rate);
    }
  }

  function adoptInitCat() public {
    bytes32 userId = getUserId(_msgSender());

    // adoption number check
    uint32 adoptionNum = UserAdoptions.get(userId);
    require(adoptionNum == 0, "You have already adopted the first cat");
    UserAdoptions.set(userId, 1);

    bytes32 catId = getUniqueEntity();

    UserCats.setObtainTime(userId, catId, block.timestamp);
    UserCats.setStatus(userId, catId, 1);
    UserCatList.pushCatIds(userId, catId);
    /**
     * Attributes Generation
     *
     */
    bool sex = getSimpleRandomBool();
    // init cat is traveling cat by default
    bytes32 hobbyId = keccak256(abi.encodePacked("travel"));
    uint256 personality = getSimpleRandomInt(1000000000);
    uint256 skin = getSimpleRandomInt(12);
    uint32 hunger = 50;
    uint32 fun = 50;
    uint32 health = 200;
    uint8 cleanLevel = 5;
    uint256 birthTime = block.timestamp;

    CatAttributes.set(catId, sex, bytes32(0), bytes32(0), hobbyId, personality, skin, birthTime);

    Cats.set(catId, userId, 0, 1, hunger, fun, health, cleanLevel, 0, 0);
  }

  // always use this function to get the cat's status before any operation
  function getCatHunger(bytes32 catId) public returns (uint32) {
    liveUpdate(catId);
    uint32 hunger = Cats.getHunger(catId);
    return hunger;
  }

  // always use this function to get the cat's status before any operation
  function getCatFun(bytes32 catId) public returns (uint32) {
    liveUpdate(catId);
    uint32 fun = Cats.getFun(catId);
    return fun;
  }

  // always use this function to get the cat's status before any operation
  function getCatHungerAndFun(bytes32 catId) public returns (uint32, uint32) {
    liveUpdate(catId);
    uint32 hunger = Cats.getHunger(catId);
    uint32 fun = Cats.getFun(catId);
    return (hunger, fun);
  }

  /**
   *
   * Notice: we do not judge if the itemId is a food item here.
   *
   */
  function feed(bytes32 catId, bytes32 itemId, uint32 quantity) public {
    bytes32 userId = getUserId(_msgSender());
    IWorld world = getWorld();
    require(UserCats.getStatus(userId, catId) == 1, "The cat is not here");
    // item consumption
    world.decItem(userId, itemId, quantity);

    uint32 hungerAdd = FoodConfig.getHunger(itemId) * quantity;
    uint32 hunger = Cats.getHunger(catId);
    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 newHunger = hunger + hungerAdd;
    // avoid overflow
    if (newHunger > hungerLimit) {
      newHunger = hungerLimit;
    }
    // update hunger
    Cats.setHunger(catId, newHunger);

    // update cat general drop rate
    CatHobbyStatus.setDropRate(catId, FoodConfig.getDropRate(itemId));
  }

  // call back cats lost temporarily
  function callBack(bytes32 catId) public {
    bytes32 userId = getUserId(_msgSender());
    require(UserCats.getStatus(userId, catId) == 3, "The cat has not left");
    UserCats.setStatus(userId, catId, 1);
  }

  // used for client to check if the cat can live update
  function canLiveUpdate(bytes32 catId) public view returns (bool) {
    // get basic cat status
    bytes32 userId = Cats.getOwnerId(catId);
    uint8 status = UserCats.getStatus(userId, catId);
    // if the cat is lost, do nothing
    if (status > 2) {
      return false;
    }

    uint256 lastUpdateTime = Cats.getLastUpdateTime(catId);
    if (lastUpdateTime == 0) {
      return true;
    }
    uint256 timeDiff = block.timestamp - lastUpdateTime;
    if (timeDiff == 0) {
      return false;
    }
    return true;
  }

  function catLostForever(bytes32 catId) internal {
    //TODO: cancel the cat's active activities
    bytes32 userId = Cats.getOwnerId(catId);
    UserCats.setStatus(userId, catId, 4);
    Cats.setFun(catId, 0);
    Cats.setHunger(catId, 0);
    UserCats.setFriendshipExp(userId, catId, 0);
    UserCats.setFriendshipLevel(userId, catId, 0);
  }

  function catLostTemp(bytes32 catId) internal {
    //TODO: cancel the cat's active activities
    bytes32 userId = Cats.getOwnerId(catId);
    UserCats.setStatus(userId, catId, 3);
    Cats.setFun(catId, 0);
    Cats.setHunger(catId, 0);
    UserCats.setFriendshipExp(userId, catId, 0);
    uint32 currentFriendshipLevel = UserCats.getFriendshipLevel(userId, catId);
    if (currentFriendshipLevel == 0) {
      return;
    } else {
      UserCats.setFriendshipLevel(userId, catId, currentFriendshipLevel - 1);
    }
  }

  function catLost(bytes32 catId, uint32 friendshipLevel) internal {
    // deal jobs before remove the cat
    beforeRemoveCat(catId);
    // check if the cat will be lost forever
    uint32 foreverFriendshipLevel = CatConfig.getForeverFriendshipLevel();
    if (friendshipLevel < foreverFriendshipLevel) {
      catLostForever(catId);
      return;
    } else {
      catLostTemp(catId);
      return;
    }
  }

  function autoFeederFeedAll(bytes32[] calldata catIds) public {
    for (uint256 i = 0; i < catIds.length; i++) {
      autoFeederFeed(catIds[i]);
    }
  }

  // anyone can call this function to update the cat's status by auto feeder
  // this function must be called each time before the cat's hunger and fun status is read
  // this function can called after fill the auto feeder
  // ignore if some cats will be fulled before the update
  // ignore if some cats are doing activities
  function autoFeederFeed(bytes32 catId) public {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 leftHunger = AutoFeeder.getHunger(userId);
    uint32 autoFeedRatio = CatAutoFeederStatus.getAutoFeedRatio(catId);
    // calculate the left hunger for this cat
    // In fact, if player autoFeedUpdate more for one cat, this cat can get more food
    uint32 leftHungerPart = (leftHunger * autoFeedRatio) / 10000;
    // no food left for this cat in the autoFeeder, do nothing
    if (leftHungerPart == 0) {
      return;
    }
    // get basic cat status
    uint8 status = UserCats.getStatus(userId, catId);
    // if the cat is lost, do nothing
    if (status > 2) {
      return;
    }
    // check if it is the first time to auto feed, if so, init the lastAutoFeedTime and skip this feed
    uint256 lastAutoFeedTime = CatAutoFeederStatus.getLastAutoFeedTime(catId);
    // init auto feed, wait for the next time
    if (lastAutoFeedTime == 0) {
      lastAutoFeedTime = block.timestamp;
      return;
    }

    // calculate the hunger to be added
    uint256 timeDiff = block.timestamp - lastAutoFeedTime;
    uint32 feedRate = AutoFeederConfig.get();

    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 hunger = Cats.getHunger(catId);
    uint32 catFeedHunger = hungerLimit - hunger;
    // if the cat's hunger is not full
    if (catFeedHunger > 0) {
      if (leftHungerPart < catFeedHunger) {
        catFeedHunger = leftHungerPart;
      }
      uint32 timedHunger = uint32((uint256(feedRate) * timeDiff * uint256(hungerLimit)) / 10000);
      if (timedHunger < catFeedHunger) {
        catFeedHunger = timedHunger;
      }
      // update the cat's hunger
      Cats.setHunger(catId, hunger + catFeedHunger);
      // update the cat's lastAutoFeedTime
      CatAutoFeederStatus.setLastAutoFeedTime(catId, block.timestamp);
      // update the autoFeeder's left hunger
      AutoFeeder.setHunger(userId, leftHunger - catFeedHunger);
    }
  }

  function updateHobbyHungerConsumption(bytes32 catId) public returns (uint32) {
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
        uint8 hobbyTier = HobbyLog.getTier(hobbyLogId);
        uint32 hobbyConsumptionRate = HobbyTierConfig.getHungerConsumptionRate(hobbyLogId, hobbyTier);
        uint32 level = Cats.getLevel(catId);
        uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
        hobbyConsumption = uint32((uint256(hobbyConsumptionRate) * timeDiff * uint256(hungerLimit)) / 10000);

        HobbyLog.setLastUpdateTime(hobbyLogId, block.timestamp);
      }
    }
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
      uint256 starvingTimeLimit = CatFriendshipLevelConfig.getStarvingTimeLimit(friendshipLevel);
      uint256 starvingStartTime = CatConfig.getStarvingStartTime();

      // cat has chance to leave each day if it has been starving for a long time
      if (starvingDuration > starvingStartTime) {
        // use simple random here, each day the cat has a fix chance to leave if invoke this function
        uint256 randSeed = uint256(keccak256(abi.encodePacked((block.timestamp) % 86400, catId)));
        uint256 rand = randSeed % starvingTimeLimit;
        // assume starvingStartTime is less than starvingTimeLimit, this can be ensured by init game designer
        if (rand > starvingDuration) {
          catLost(catId, friendshipLevel);
          return;
        }
      }

      // if the cat is starving too long, it will leave
      if (starvingDuration >= starvingTimeLimit) {
        catLost(catId, friendshipLevel);
        return;
      }
    }
  }

  function calculateBasicHungerConsumption(bytes32 catId, uint256 timeDiff) public view returns (uint32) {
    uint32 hunger = Cats.getHunger(catId);
    // calculate new status
    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 hungerConsumeRateBase = CatConfig.getHungerConsumeRate();
    // calculate the basic hunger consumption
    uint32 hungerConsumption = uint32((uint256(hungerConsumeRateBase) * uint(hungerLimit) * timeDiff) / 10000);
    return hungerConsumption;
  }

  function calculateBasicFunConsumption(bytes32 catId, uint256 timeDiff) public view returns (uint32) {
    // get cat status
    uint32 fun = Cats.getFun(catId);

    // calculate new status
    uint32 level = Cats.getLevel(catId);
    uint32 funLimit = CatLevelConfig.getFunLimit(level);

    uint32 funConsumeRate = CatConfig.getFunConsumeRate();
    uint32 funConsumption = uint32((uint256(funConsumeRate) * uint256(funLimit) * timeDiff) / 10000);
    return funConsumption;
  }

  // anyone can call this function to update the cat's status
  // this function must be called each time before the cat's hunger and fun status is read
  function liveUpdate(bytes32 catId) public {
    // check if can live update
    uint256 lastUpdateTime = Cats.getLastUpdateTime(catId);
    if (lastUpdateTime == 0) {
      lastUpdateTime = block.timestamp;
      return;
    }
    uint256 timeDiff = block.timestamp - lastUpdateTime;
    if (timeDiff == 0) {
      return;
    }

    // get basic cat status
    bytes32 userId = Cats.getOwnerId(catId);
    uint8 status = UserCats.getStatus(userId, catId);
    // if the cat is lost, do nothing
    if (status > 2) {
      return;
    }
    // update hobby hunger consumption
    uint32 hobbyHungerConsumption = updateHobbyHungerConsumption(catId);

    // get cat status
    uint32 fun = Cats.getFun(catId);
    uint32 hunger = Cats.getHunger(catId);

    // calculate the basic hunger consumption
    uint32 hungerConsumption = calculateBasicHungerConsumption(catId, timeDiff);
    // add the hobby activity consumption to get the total hunger consumption
    hungerConsumption += hobbyHungerConsumption;
    uint32 funConsumption = calculateBasicFunConsumption(catId, timeDiff);
    uint32 newHunger;
    if (hungerConsumption >= hunger) {
      newHunger = 0;
    } else {
      newHunger -= hungerConsumption;
    }
    uint32 newFun;
    if (funConsumption >= fun) {
      newFun = 0;
    } else {
      newFun -= funConsumption;
    }

    _starvingUpdate(catId, hunger, newHunger);

    // update status
    Cats.setHunger(catId, newHunger);
    Cats.setFun(catId, newFun);

    // autoFeeder feed udpate
    autoFeederFeed(catId);

    Cats.setLastUpdateTime(catId, block.timestamp);
  }
}
