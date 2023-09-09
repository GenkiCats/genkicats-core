// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { AutoFeeder, AutoFeederConfig } from "../codegen/Tables.sol";
import { AutoFeederStatus, Cats, CatConfig, CatLevelConfig, UserCats } from "../codegen/Tables.sol";

contract AutoFeederSystem is System {
  function autoFeedAll(bytes32[] calldata catIds) public {
    for (uint256 i = 0; i < catIds.length; i++) {
      autoFeed(catIds[i]);
    }
  }

  function calculateAutoFeed(uint32 hunger, bytes32 userId, bytes32 catId) public view returns (uint32, uint32) {
    uint32 leftHunger = AutoFeeder.getHunger(userId);
    uint32 autoFeedRatio = AutoFeederStatus.getFeedRatio(catId);
    // calculate the left hunger for this cat
    // In fact, if player autoFeedUpdate more for one cat, this cat can get more food
    uint32 leftHungerPart = (leftHunger * autoFeedRatio) / 10000;
    // no food left for this cat in the autoFeeder, do nothing
    if (leftHungerPart == 0) {
      return (hunger, leftHunger);
    }
    // get basic cat status
    uint8 status = UserCats.getStatus(userId, catId);
    // if the cat is lost, do nothing
    if (status > 2) {
      return (0, leftHunger);
    }
    // check if it is the first time to auto feed, if so, init the lastAutoFeedTime and skip this feed
    uint256 lastAutoFeedTime = AutoFeederStatus.getLastFeedTime(catId);
    // init auto feed, wait for the next time
    if (lastAutoFeedTime == 0) {
      lastAutoFeedTime = block.timestamp;
      return (hunger, leftHunger);
    }

    // calculate the hunger to be added
    uint256 timeDiff = block.timestamp - lastAutoFeedTime;
    uint32 feedRate = AutoFeederConfig.get();

    uint32 level = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(level);
    uint32 catFeedHunger = hungerLimit - hunger;

    uint32 catNewHunger = hunger;
    uint32 feederNewHunger = leftHunger;
    // if the cat's hunger is not full
    if (catFeedHunger > 0) {
      if (leftHungerPart < catFeedHunger) {
        catFeedHunger = leftHungerPart;
      }
      uint32 timedHunger = uint32((uint256(feedRate) * timeDiff * uint256(hungerLimit)) / 10000);
      if (timedHunger < catFeedHunger) {
        catFeedHunger = timedHunger;
      }
      catNewHunger += catFeedHunger;
      feederNewHunger -= catFeedHunger;
    }
    return (catNewHunger, feederNewHunger);
  }

  // anyone can call this function to update the cat's status by auto feeder
  // this function must be called each time before the cat's hunger and fun status is read
  // this function can called after fill the auto feeder
  // ignore if some cats will be fulled before the update
  // ignore if some cats are doing activities
  function autoFeed(bytes32 catId) public {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 hunger = Cats.getHunger(catId);
    (uint32 newCatHunger, uint32 newFeederHunger) = calculateAutoFeed(hunger, userId, catId);
    if (newCatHunger != hunger) {
      // update the cat's hunger
      Cats.setHunger(catId, newCatHunger);
      // update the autoFeeder's left hunger
      AutoFeeder.setHunger(userId, newFeederHunger);
    }
    // update the cat's lastAutoFeedTime
    AutoFeederStatus.setLastFeedTime(catId, block.timestamp);
  }
}
