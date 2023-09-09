// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
// User
import { UserCats, UserStatus, UserLevelConfig } from "../codegen/Tables.sol";
// Cats
import { Cats, CatConfig, CatAttributes, CatLevelConfig, PlayerInitConfig } from "../codegen/Tables.sol";
// Food
import { FoodConfig, BuffStatus, BuffConfig } from "../codegen/Tables.sol";
// Hobby
import { HobbyBasicConfig, HobbyRandomSourceConfig, HobbyConfig, HobbyTierConfig, HobbyLog, CatHobbyStatus, HobbyExtraStepsConfig } from "../codegen/Tables.sol";
// Random
import { GlobalRandomSourceConfig } from "../codegen/Tables.sol";

import { IWorld } from "../codegen/world/IWorld.sol";
import { IRandomGenerator } from "./helpers/IRandomGenerator.sol";

import { LibRandom } from "./libs/LibRandom.sol";
import { LibPrecision } from "./libs/LibPrecision.sol";
import { LibBuff } from "./libs/LibBuff.sol";

//TODO: remove in production
import "forge-std/console.sol";

contract HobbySystem is System {
  // this function should be called before the hobby tag chosen
  // recommend this function to be called not too long before the hobby tag chosen
  // or the random seed has chance to be lost to 0 if no one commit the random source
  // so the client can call this function more than once if wait too long for players choosing tag
  // If the hobbyConfig set strictRandom to true, then players need to requestRandomSeed again if the random seed has been outdated
  // or will use block.timestamp as the entropy source to generate random seed
  function requestRandomSeed(bytes32 catId, bytes32 hobbyId) public {
    bytes32 userId = Cats.getOwnerId(catId);
    // check cat owner
    require(userId == getUserId(_msgSender()), "only owner can request random seed");
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
    if (rawRandomSeed == 0) {
      if (strictRandom == true) {
        //TODO: if the random commit is not frequently, this can be exploited by players to wait for the outdated deliberately
        revert("The random seed has been outdated, please request random seed again");
      } else {
        // use block.timestamp as the entropy source under non-strict random mode
        rawRandomSeed = block.timestamp;
      }
    }

    uint256 randomSeed = uint256(keccak256(abi.encode(rawRandomSeed, userId, catId, hobbyId)));
    return randomSeed;
  }

  function getHobbyTier(bytes32 hobbyId, bytes32 catId, uint256 randomSeed) public view returns (uint8) {
    IWorld world = getWorld();
    uint8 tier = world.getHobbyTierBySeed(hobbyId, catId, randomSeed);
    return tier;
  }

  function getPlayerChosenTags(
    bytes32 hobbyId,
    bytes32 catId,
    uint8 tier,
    uint256 randomSeed
  ) public view returns (bytes32[] memory) {
    uint8 playerChosenTagNum = HobbyConfig.getPlayerChosenTagNum(hobbyId);
    // if tagChosenRange is 0, then player cannot choose tag for this hobby
    if (playerChosenTagNum == 0) {
      return new bytes32[](0);
    } else {
      // @HobbyHelperSystem
      bytes32[] memory tags = getWorld().getHobbyTagsBySeed(hobbyId, tier, randomSeed, playerChosenTagNum);
      return tags;
    }
  }

  function _isTagValid(
    bytes32 hobbyId,
    bytes32 catId,
    uint8 tier,
    bytes32 tagId,
    uint256 randomSeed
  ) internal view returns (bool) {
    bytes32[] memory tags = getPlayerChosenTags(hobbyId, catId, tier, randomSeed);
    bool validTag = false;
    for (uint8 i = 0; i < tags.length; i++) {
      if (tags[i] == tagId) {
        validTag = true;
        break;
      }
    }
    return validTag;
  }

  function getLastHobbyStatus(
    bytes32 hobbyId,
    bytes32 lastHobbyLogId
  ) internal view returns (uint32, uint8, bytes32, uint32) {
    uint8 tier;
    bytes32 tagId;
    uint32 tierTagIndex;
    // check if need to copy the last hobby log when in multiple steps status
    if (lastHobbyLogId != bytes32(0)) {
      tier = HobbyLog.getTier(lastHobbyLogId);
      tagId = HobbyLog.getTagId(lastHobbyLogId);
      tierTagIndex = HobbyLog.getTierTagIndex(lastHobbyLogId);
      uint32 extraStepsRequired = HobbyExtraStepsConfig.getItem(hobbyId, tier, tagId, tierTagIndex);
      uint32 lastStep = HobbyLog.getStep(lastHobbyLogId);
      if (lastStep < extraStepsRequired) {
        // if the last hobby log is not finished, then continue on the new log
        return (lastStep + 1, tier, tagId, tierTagIndex);
      } else {
        // if the last hobby log is finished, then start a new log
        // steps starts from 0
        return (0, 0, bytes32(0), 0);
      }
    } else {
      // no last hobby log, then start a new log
      // steps starts from 0
      return (0, 0, bytes32(0), 0);
    }
  }

  function isCatResting(bytes32 catId, bytes32 hobbyId, uint8 tier) public view returns (bool) {
    uint256 lastEventFinishTime = CatHobbyStatus.getLastEventFinishTime(catId);
    uint256 baseRestTime = HobbyTierConfig.getBaseRestTime(hobbyId, tier);
    return block.timestamp < lastEventFinishTime + baseRestTime;
  }

  function getCatHungerConsumption(bytes32 hobbyId, bytes32 catId, uint256 timeDiff) public view returns (uint32) {
    uint32 hobbyConsumptionRate = HobbyConfig.getHungerConsumptionRate(hobbyId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(Cats.getLevel(catId));
    uint32 hobbyConsumption = uint32(
      (uint256(hobbyConsumptionRate) * timeDiff * uint256(hungerLimit)) / LibPrecision.CONSUMPTION_PRECISION
    );
    return hobbyConsumption;
  }

  function getDropRate(bytes32 catId) public view returns (uint32) {
    uint32 dropRate = CatConfig.getBaseDropRate();
    bytes32 buffId = BuffStatus.getBuffId(0, catId, LibBuff.DROP_RATE_MUL_BUFF_TYPE);
    uint256 buffStartTime = BuffStatus.getStartTime(0, catId, LibBuff.DROP_RATE_MUL_BUFF_TYPE);
    if (LibBuff.isBuffValid(buffId, buffStartTime)) {
      uint256 dropRateFactor = BuffConfig.getBuffValue(buffId);
      dropRate = uint32((uint256(dropRate) * dropRateFactor) / LibPrecision.PROB_PRECISION);
    }
    console.log("dropRate: %s", uint256(dropRate));
    return dropRate;
  }

  function getCoinReward(bytes32 catId, uint32 requiredHunger, uint256 randomSeed) public view returns (uint256) {
    uint32 hungerCoinRate = CatConfig.getBaseHungerCoinRate();
    bytes32 buffId = BuffStatus.getBuffId(0, catId, LibBuff.COIN_RATE_MUL_BUFF_TYPE);
    uint256 buffStartTime = BuffStatus.getStartTime(0, catId, LibBuff.COIN_RATE_MUL_BUFF_TYPE);
    if (LibBuff.isBuffValid(buffId, buffStartTime)) {
      uint256 hungerCoinRateFactor = BuffConfig.getBuffValue(buffId);
      hungerCoinRate = uint32((uint256(hungerCoinRate) * hungerCoinRateFactor) / LibPrecision.PROB_PRECISION);
    }

    uint256 coinReward = (requiredHunger * hungerCoinRate) / LibPrecision.CONVERSION_PRECISION;
    console.log("coinReward: %s", coinReward);
    return coinReward;
  }

  function getCatExpReward(bytes32 catId, uint32 requiredHunger, uint256 randomSeed) public view returns (uint32) {
    uint32 hungerCatExpRate = HobbyBasicConfig.getHungerCatExpRate();
    console.log("hungerCatExpRate: %s", uint256(hungerCatExpRate));
    uint32 catExpReward = (requiredHunger * hungerCatExpRate) / LibPrecision.CONVERSION_PRECISION;
    console.log("catExpReward: %s", uint256(catExpReward));
    return catExpReward;
  }

  function getUserExpReward(bytes32 userId, uint32 requiredHunger, uint256 randomSeed) public view returns (uint32) {
    // get user exp
    uint32 hungerUserExpRate = HobbyBasicConfig.getHungerUserExpRate();
    console.log("hungerUserExpRate: %s", uint256(hungerUserExpRate));
    uint32 userExpReward = (requiredHunger * hungerUserExpRate) / LibPrecision.CONVERSION_PRECISION;
    console.log("userExpReward: %s", uint256(userExpReward));
    return userExpReward;
  }

  function getDuration(bytes32 hobbyId, uint8 tier, uint256 randomSeed) public view returns (uint256) {
    // get activity time
    uint256 baseTime = HobbyTierConfig.getBaseTime(hobbyId, tier);

    // @RandDisturbHelperSystem
    // 50%~150% disturb
    uint256 activityTime = LibRandom.getSimpleRandDisturbResult(
      baseTime,
      baseTime / 2,
      randomSeed,
      "hobbyEventDuration"
    );
    console.log("activityTime: %s", activityTime);
    return activityTime;
  }

  function updateRewardItems(bytes32 logId, bytes32 hobbyId, uint8 tier, bytes32 tagId, uint256 randomSeed) internal {
    // decide if drop reward
    if (randomSeed % LibPrecision.PROB_PRECISION < HobbyLog.getDropRate(logId)) {
      // get reward item
      // @HobbyHelperSystem
      bytes32[] memory rewardItems = getWorld().getHobbyRewardItemsBySeed(hobbyId, tier, tagId, randomSeed);
      for (uint256 i = 0; i < rewardItems.length; i++) {
        console.log("rewardItems: %s", uint256(rewardItems[i]));
      }
      HobbyLog.setRewardItems(logId, rewardItems);
    } else {
      HobbyLog.setRewardItems(logId, new bytes32[](0));
    }
    console.log("reward items set");
  }

  // choose tag and start activity
  // the tagId should be in the tag range
  function startActivity(bytes32 catId, bytes32 hobbyId, bytes32 tagId) public {
    bytes32 userId = getUserId(_msgSender());
    require(Cats.getOwnerId(catId) == userId, "Only cat owner can start activity");

    IWorld world = getWorld();
    // update cat status
    world.liveUpdate(catId);
    require(Cats.getFun(catId) > 0, "The cat is not happy");

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

    uint8 tier;
    uint32 tierTagIndex;
    uint32 step;
    // check if the hobby has extra steps
    if (HobbyConfig.getHasExtraSteps(hobbyId) == true) {
      // if true, check if the last step has been finished
      // and get the config from the last log
      (step, tier, tagId, tierTagIndex) = getLastHobbyStatus(hobbyId, lastHobbyLogId);
      HobbyLog.setStep(logId, step);
    }

    // if need to start a new recor
    if (step == 0) {
      // Tier
      tier = world.getHobbyTierBySeed(hobbyId, catId, randomSeed);
      console.log("tier: %s", uint256(tier));
      HobbyLog.setTier(logId, tier);

      // TagId
      if (HobbyConfig.getPlayerChosenTagNum(hobbyId) == 0) {
        // if the hobby has no tag players can chosen, then ignore the user input tag
        // and get tagId from random seed
        tagId = world.getHobbyTagBySeed(hobbyId, tier, randomSeed);
      } else {
        // check if the user input tag is valid in the predetermined tag range
        require(
          _isTagValid(hobbyId, catId, tier, tagId, randomSeed),
          "The tag is not in the valid tag range, or check if the random seed is outdated after tag chosen"
        );
      }
      console.log("tagId: %s", uint256(tagId));
      HobbyLog.setTagId(logId, tagId);

      // TierTagIndex
      tierTagIndex = uint32(world.getHobbyRewardItemIndexBySeed(hobbyId, tier, tagId, randomSeed));
      console.log("tierTagIndex: %s", uint256(tierTagIndex));
      // record the tierTagIndex
      HobbyLog.setTierTagIndex(logId, tierTagIndex);
    }

    // check if the cat is resting
    require(!isCatResting(catId, hobbyId, tier), "The cat is resting");

    //TODO: average drop rate in multiple steps activities
    HobbyLog.setDropRate(logId, getDropRate(catId));
    console.log("dropRate set");

    // set startTime to now to start consuming hunger
    uint256 duration = getDuration(hobbyId, tier, randomSeed);
    HobbyLog.setStartTime(logId, block.timestamp);
    // set the end time of this activity
    HobbyLog.setEndTime(logId, block.timestamp + duration);
    console.log("end time set");

    // calculate the required hunger based on the duration
    uint32 requiredHunger = getCatHungerConsumption(hobbyId, catId, duration);
    console.log("requiredHunger: %s", uint256(requiredHunger));
    // we have invoke liveUpdate before, so the hunger should be up to date and we can directly read it
    // ignore the cat basic hunger consumption here
    require(requiredHunger <= Cats.getHunger(catId), "The cat is too hungry");

    // set coin and exp reward
    setBaseRewards(catId, userId, logId, requiredHunger, randomSeed);
    // set reward items
    updateRewardItems(logId, hobbyId, tier, tagId, randomSeed);
  }

  function setBaseRewards(
    bytes32 catId,
    bytes32 userId,
    bytes32 logId,
    uint32 requiredHunger,
    uint256 randomSeed
  ) internal {
    HobbyLog.setRewardCoins(logId, getCoinReward(catId, requiredHunger, randomSeed));
    console.log("reward coin set");

    HobbyLog.setRewardCatExp(logId, getCatExpReward(catId, requiredHunger, randomSeed));
    console.log("reward cat exp set");

    HobbyLog.setRewardUserExp(logId, getUserExpReward(userId, requiredHunger, randomSeed));
    console.log("reward cat user set");
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
    console.log("rewardCoins: %s", uint256(rewardCoins));
    // add cat exp
    world.addCatExp(catId, rewardCatExp);
    console.log("rewardCatExp: %s", uint256(rewardCatExp));

    // add user exp
    world.addUserExp(userId, rewardUserExp);
    console.log("rewardUserExp: %s", uint256(rewardUserExp));

    // transfer reward items
    for (uint256 i = 0; i < rewardItems.length; i++) {
      bytes32 rewardItemId = rewardItems[i];
      world.addItem(userId, rewardItemId, 1);
    }
    console.log("Claim finish");
  }
}
