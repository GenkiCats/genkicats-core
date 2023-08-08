// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
// User
import { UserCats, UserStatus, UserLevelConfig } from "../codegen/Tables.sol";
// Cats
import { Cats, CatAttributes, CatLevelConfig, PlayerInitConfig } from "../codegen/Tables.sol";
// Food
import { FoodConfig } from "../codegen/Tables.sol";
// Hobby
import { HobbyBasicConfig, HobbyRandomSourceConfig, HobbyConfig, HobbyTierConfig, HobbyLog, CatHobbyStatus, HobbyRewardStepsConfig } from "../codegen/Tables.sol";
// Random
import { GlobalRandomSourceConfig } from "../codegen/Tables.sol";

import { IWorld } from "../codegen/world/IWorld.sol";
import { IRandomGenerator } from "./helpers/IRandomGenerator.sol";

contract HobbySystem is System {
  // this function should be called before the hobby tag chosen
  // recommend this function to be called not too long before the hobby tag chosen
  // or the random seed has chance to be lost to 0 if no one commit the random source
  // so the client can call this function more than once if wait too long for players choosing tag
  // If the hobbyConfig set strictRandom to true, then players need to requestRandomSeed again if the random seed has been outdated
  // or will use block.timestamp as the entropy source to generate random seed
  function requestRandomSeed(bytes32 catId, bytes32 hobbyId) public {
    bytes32 userId = Cats.getOwnerId(catId);
    // can only generate new log after the last log is finished
    require(UserCats.getStatus(userId, catId) == 1, "The cat is not here");

    bytes32 currentLogId = CatHobbyStatus.getCurrentLogId(catId);
    bytes32 latestLogId = CatHobbyStatus.getLatestLogId(catId);
    if (currentLogId == latestLogId) {
      // generate logId
      latestLogId = keccak256(abi.encode(hobbyId, userId, catId, block.number, block.timestamp));
    }
    // if the current log id existed
    if (currentLogId != bytes32(0)) {
      // if player abort the last hobby activity, then the last rand seed and requestRandBlock will be copied to the current one
      uint8 activityStatus = HobbyLog.getStatus(currentLogId);
      // canceled activity
      if (activityStatus == 4) {
        uint256 randomSeed = HobbyLog.getRandomSeed(currentLogId);
        HobbyLog.setRandomSeed(latestLogId, randomSeed);
        uint256 requestRandBlock = HobbyLog.getRequestRandBlock(currentLogId);
        HobbyLog.setRequestRandBlock(latestLogId, requestRandBlock);
      }
    }

    uint256 currentRequestRandBlock = HobbyLog.getRequestRandBlock(latestLogId);
    // player still has the chance to retry multiple times by waiting the random seed to be outdated if the random source commmit is not frequently enough
    // this can be mitigated by the popularity of the random source and increase the waiting blocks in the random source
    if (currentRequestRandBlock == 0 || getRawRandomSeed(hobbyId) == 0) {
      // record the request block number
      HobbyLog.setRequestRandBlock(latestLogId, block.number);
      // only generate new log, but not change the CatHobbyStatus's currentLogId
      CatHobbyStatus.setLatestLogId(catId, latestLogId);
    }
  }

  // TODO: canRequestRandom() public view function for client to check if can request random seed

  function getRawRandomSeed(bytes32 hobbyId) public view returns (uint256) {
    IRandomGenerator randomGenerator = IRandomGenerator(GlobalRandomSourceConfig.get());
    uint32 delayBlocks = HobbyRandomSourceConfig.getDelayBlocks(hobbyId);
    bytes32 logId = CatHobbyStatus.getLatestLogId(hobbyId);
    uint256 requestBlockNumber = HobbyLog.getRequestRandBlock(logId);
    require(requestBlockNumber + delayBlocks <= block.number, "The random seed is not ready yet");
    uint256 randomSeed = randomGenerator.getRandom(requestBlockNumber, uint256(delayBlocks));
    return randomSeed;
  }

  function getCatRandomSeed(bytes32 hobbyId, bytes32 userId, bytes32 catId) public view returns (uint256) {
    uint256 rawRandomSeed = getRawRandomSeed(hobbyId);
    bool strictRandom = HobbyRandomSourceConfig.getStrictRandom(hobbyId);
    if (strictRandom == true) {
      if (rawRandomSeed == 0) {
        revert("The random seed has been outdated");
      }
    }
    uint256 randomSeed = uint256(keccak256(abi.encode(rawRandomSeed, userId, catId, hobbyId, block.timestamp)));
    return randomSeed;
  }

  function getTagRange(
    bytes32 hobbyId,
    bytes32 userId,
    bytes32 catId,
    uint256 randomSeed
  ) public view returns (bytes32[] memory) {
    uint8 tagChosenRange = HobbyConfig.getTagChosenRange(hobbyId);
    IWorld world = getWorld();
    // @HobbyConfigSystem
    uint8 tier = world.getHobbyRewardTierBySeed(world, hobbyId, randomSeed);
    // @HobbyConfigSystem
    bytes32[] memory tags = world.getHobbyRewardTagsBySeed(world, hobbyId, tier, randomSeed, tagChosenRange);
    return tags;
  }

  function _checkTagValid(
    bytes32 hobbyId,
    bytes32 userId,
    bytes32 catId,
    bytes32 tagId,
    uint256 randomSeed
  ) internal view returns (bool) {
    bytes32[] memory tags = getTagRange(hobbyId, userId, catId, randomSeed);
    bool validTag = false;
    for (uint8 i = 0; i < tags.length; i++) {
      if (tags[i] == tagId) {
        validTag = true;
        break;
      }
    }
    return validTag;
  }

  function _checkMultipleStepsLog(
    bytes32 lastHobbyLogId,
    bytes32 newLogId,
    bytes32 hobbyId,
    bytes32 tagId
  ) internal returns (uint8, bytes32, uint32) {
    uint8 tier;
    uint32 tierTagIndex;
    // check if need to copy the last hobby log when in multiple steps status
    if (lastHobbyLogId != bytes32(0)) {
      // check if hobby log is in multiple steps status
      // Remember that one cat can only do one hobby all the time, so we can directly use this hobbyId
      bool hasExtraSteps = HobbyConfig.getHasExtraSteps(hobbyId);
      if (hasExtraSteps) {
        tier = HobbyLog.getTier(lastHobbyLogId);
        tagId = HobbyLog.getTagId(lastHobbyLogId);
        tierTagIndex = HobbyLog.getTierTagIndex(lastHobbyLogId);
        uint32 maxStepNum = HobbyRewardStepsConfig.getItem(hobbyId, tier, tagId, tierTagIndex);
        uint32 currentStepNum = HobbyLog.getStepNum(lastHobbyLogId);
        if (currentStepNum < maxStepNum) {
          // if the last hobby log is not finished, then continue on the new log
          HobbyLog.setStepNum(newLogId, currentStepNum + 1);
        }
      }
    }
    return (tier, tagId, tierTagIndex);
  }

  function isCatResting(bytes32 catId, bytes32 hobbyId, uint8 tier) public view returns (bool) {
    uint256 lastEventFinishTime = CatHobbyStatus.getLastEventFinishTime(catId);
    uint256 baseRestTime = HobbyTierConfig.getBaseRestTime(hobbyId, tier);
    return block.timestamp < lastEventFinishTime + baseRestTime;
  }

  function getCatHungerConsumption(bytes32 hobbyId, bytes32 catId, uint8 tier) public view returns (uint32) {
    // get hunger consumption rate
    uint32 hungerConsumptionRate = HobbyTierConfig.getHungerConsumptionRate(hobbyId, tier);
    // check if the cat can afford the hunger consumption
    uint32 requiredHunger = (CatLevelConfig.getHungerLimit(Cats.getLevel(catId)) * hungerConsumptionRate) / 10000;
    return requiredHunger;
  }

  function getDropRate(bytes32 lastFeedFoodId) public view returns (uint32) {
    uint32 dropRate;
    // if the cat has never been fed, use init rate
    if (lastFeedFoodId == 0) {
      dropRate = PlayerInitConfig.getInitDropRate();
    } else {
      dropRate = FoodConfig.getDropRate(lastFeedFoodId);
    }
    return dropRate;
  }

  function getCoinReward(
    bytes32 lastFeedFoodId,
    uint32 requiredHunger,
    uint256 randomSeed,
    IWorld world
  ) public view returns (uint256) {
    uint32 hungerCoinRate;
    // if the cat has never been fed, use init rate
    if (lastFeedFoodId == 0) {
      hungerCoinRate = PlayerInitConfig.getInitHungerCoinRate();
    } else {
      hungerCoinRate = FoodConfig.getHungerCoinRate(lastFeedFoodId);
    }
    uint256 coinRewardBase = (requiredHunger * hungerCoinRate) / 10000;
    // @RandDisturbHelperSystem
    // 80%~120% disturb
    uint256 coinReward = world.getSimpleRandDisturbResult(coinRewardBase, coinRewardBase / 5, randomSeed);
    return coinReward;
  }

  function getCatExpReward(
    bytes32 catId,
    uint32 requiredHunger,
    uint256 randomSeed,
    IWorld world
  ) public view returns (uint32) {
    uint32 hungerCatExpRate = HobbyBasicConfig.getHungerCatExpRate();
    uint32 catExpLimit = CatLevelConfig.getExpLimit(Cats.getLevel(catId));
    uint32 catExpRewardBase = (requiredHunger * hungerCatExpRate) / 10000;
    // @RandDisturbHelperSystem
    // 80%~120% disturb
    uint32 catExpReward = uint32(world.getSimpleRandDisturbResult(catExpRewardBase, catExpRewardBase / 5, randomSeed));
    return catExpReward;
  }

  function getUserExpReward(
    bytes32 userId,
    uint32 requiredHunger,
    uint256 randomSeed,
    IWorld world
  ) public view returns (uint32) {
    // get user exp
    uint32 hungerUserExpRate = HobbyBasicConfig.getHungerUserExpRate();
    uint32 userExpLimit = UserLevelConfig.get(UserStatus.getLevel(userId));
    uint32 userExpRewardBase = (requiredHunger * hungerUserExpRate) / 10000;
    // @RandDisturbHelperSystem
    // 80%~120% disturb
    uint32 userExpReward = uint32(
      world.getSimpleRandDisturbResult(userExpRewardBase, userExpRewardBase / 5, randomSeed)
    );
    return userExpReward;
  }

  function getDuration(bytes32 hobbyId, uint8 tier, uint256 randomSeed, IWorld world) public view returns (uint256) {
    // get activity time
    uint256 baseTime = HobbyTierConfig.getBaseTime(hobbyId, tier);

    // @RandDisturbHelperSystem
    // 50%~150% disturb
    uint256 activityTime = world.getSimpleRandDisturbResult(baseTime, baseTime / 2, randomSeed);
    return activityTime;
  }

  function updateRewardItems(
    bytes32 logId,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randomSeed,
    IWorld world
  ) internal {
    // decide if drop reward
    if (randomSeed % 10000 < HobbyLog.getDropRate(logId)) {
      // get reward item
      // @HobbyConfigSystem
      bytes32[] memory rewardItems = world.getHobbyRewardItemsBySeed(world, hobbyId, tier, tagId, randomSeed);
      HobbyLog.setRewardItems(logId, rewardItems);
    } else {
      HobbyLog.setRewardItems(logId, new bytes32[](0));
    }
  }

  // choose tag and start activity
  // the tagId should be in the tag range
  function startActivity(bytes32 catId, bytes32 hobbyId, bytes32 tagId) public {
    bytes32 userId = getUserId(_msgSender());
    bytes32 catOwner = Cats.getOwnerId(catId);
    require(userId == catOwner, "Only cat owner can start activity");

    IWorld world = getWorld();

    // update cat status
    world.liveUpdate(catId);

    require(UserCats.getStatus(userId, catId) == 1, "The cat is not here");
    // update cat status
    UserCats.setStatus(userId, catId, 2);
    require(CatAttributes.getHobbyId(catId) == hobbyId, "The cat's hobby not match this activity");

    bytes32 lastHobbyLogId = CatHobbyStatus.getCurrentLogId(catId);
    bytes32 logId = CatHobbyStatus.getLatestLogId(catId);

    // update current log id
    CatHobbyStatus.setCurrentLogId(catId, logId);
    require(lastHobbyLogId != logId, "Has not request random seed yet");
    HobbyLog.setStatus(logId, 1); // 1: started

    // get random seed
    uint256 randomSeed = HobbyLog.getRandomSeed(logId);
    // check if the random seed has been copy from aborted log when request random seed
    if (randomSeed == 0) {
      // generate random seed
      randomSeed = getCatRandomSeed(hobbyId, userId, catId);
      // set the random seed to avoid SAVE AND LOAD
      HobbyLog.setRandomSeed(logId, randomSeed);
    }

    // check tagId is in the valid tag range
    require(
      _checkTagValid(hobbyId, userId, catId, tagId, randomSeed),
      "The tag is not in the valid tag range, check if the random seed is outdated after tag chosen"
    );
    uint8 tier;
    uint32 tierTagIndex;
    (tier, tagId, tierTagIndex) = _checkMultipleStepsLog(lastHobbyLogId, logId, hobbyId, tagId);

    // get tier
    // @HobbyConfigSystem
    // if tier not set, then get tier from random seed, notice that tier starts from 1 so 0 mean not set
    if (tier == 0) {
      tier = world.getHobbyRewardTierBySeed(world, hobbyId, randomSeed);
    }
    // record the tier
    HobbyLog.setTier(logId, tier);

    if (tagId == bytes32(0)) {
      // if tagId not set, then get one tagId from random seed
      tagId = world.getHobbyRewardTagBySeed(world, hobbyId, tier, randomSeed);
    }
    // record the tagId
    HobbyLog.setTagId(logId, tagId);

    if (tierTagIndex == 0) {
      // if tierTagIndex not set, then get tierTagIndex from random seed
      tierTagIndex = uint32(world.getHobbyRewardItemIndexBySeed(world, hobbyId, tier, tagId, randomSeed));
    }
    // record the tierTagIndex
    HobbyLog.setTierTagIndex(logId, tierTagIndex);

    // check if the cat is resting
    require(!isCatResting(catId, hobbyId, tier), "The cat is resting");

    uint32 requiredHunger = getCatHungerConsumption(hobbyId, catId, tier);
    // we have invoke liveUpdate before, so the hunger should be up to date and we can directly read it
    require(requiredHunger <= Cats.getHunger(catId), "The cat is too hungry");

    // calcuate coin reward and drop rate
    bytes32 lastFeedFoodId = CatHobbyStatus.getLastFeedFoodId(catId);
    // record drop rate
    HobbyLog.setDropRate(logId, getDropRate(lastFeedFoodId));
    // record coin gains
    HobbyLog.setRewardCoins(logId, getCoinReward(lastFeedFoodId, requiredHunger, randomSeed, world));

    // record cat exp gains
    HobbyLog.setRewardCatExp(logId, getCatExpReward(catId, requiredHunger, randomSeed, world));
    // record user exp gains
    HobbyLog.setRewardUserExp(logId, getUserExpReward(userId, requiredHunger, randomSeed, world));

    // set startTime to now to start consuming hunger
    HobbyLog.setStartTime(logId, block.timestamp);
    HobbyLog.setEndTime(logId, block.timestamp + getDuration(hobbyId, tier, randomSeed, world));

    // set reward items
    updateRewardItems(logId, hobbyId, tier, tagId, randomSeed, world);
  }

  function claimReward(bytes32 catId, bytes32 hobbyId) public {
    bytes32 logId = CatHobbyStatus.getCurrentLogId(catId);
    require(logId != 0, "The hobby log does not exist");
    require(HobbyLog.getEndTime(logId) < block.timestamp, "The hobby is not finished yet");
    require(HobbyLog.getStatus(logId) != 3, "The reward has been claimed");
    // set status to claimed
    HobbyLog.setStatus(logId, 3);

    // get reward items
    bytes32[] memory rewardItems = HobbyLog.getRewardItems(logId);
    // get reward coins
    uint256 rewardCoins = HobbyLog.getRewardCoins(logId);
    // get reward cat exp
    uint32 rewardCatExp = HobbyLog.getRewardCatExp(logId);
    // get reward user exp
    uint32 rewardUserExp = HobbyLog.getRewardUserExp(logId);

    IWorld world = getWorld();

    bytes32 userId = Cats.getOwnerId(catId);

    // @QuantityHelperSystem
    // add reward coins
    world.addCoin(userId, rewardCoins);
    // // add cat exp
    // world.addCatExp(catId, rewardCatExp);

    // // add user exp
    // world.addUserExp(userId, rewardUserExp);

    // // transfer reward items
    // for (uint256 i = 0; i < rewardItems.length; i++) {
    //   uint256 rewardItemId = rewardItems[i];
    //   world.addItems(userId, rewardItemId, 1);
    // }
  }
}
