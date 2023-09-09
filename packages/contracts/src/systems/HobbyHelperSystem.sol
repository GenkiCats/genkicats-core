// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Cats, HobbyConfig, HobbyBasicConfig, HobbyLevelTierConfig, HobbyTierConfig, HobbyRewardItemsConfig, HobbyExtraRewardConfig } from "../codegen/Tables.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";
import { LibConstants } from "./libs/LibConstants.sol";

//TODO: remove in production
import "forge-std/console.sol";

// All helper system is sub system
// Use subsystem here rather than library to avoid exceed the contract size limit
contract HobbyHelperSystem is System {
  // Notice: cannot use HobbyLevelTierConfig directly, must use by this function
  function getHobbyLevelTierConfig(bytes32 hobbyId, uint32 level) public view returns (uint8) {
    uint8 tier = HobbyLevelTierConfig.get(hobbyId, level);
    // tier cannot be zero in setter
    if (tier == 0) {
      // return default tier corrsponding level
      return HobbyLevelTierConfig.get(LibConstants.DEFAULT_HOBBY_ID, level);
    } else {
      return tier;
    }
  }

  function getHobbyTierChosenSampleId(bytes32 hobbyId, uint32 level) public view returns (bytes32) {
    uint8 tier = getHobbyLevelTierConfig(hobbyId, level);
    bytes32 sampleId = HobbyTierConfig.getTierChosenSampleId(hobbyId, tier);
    if (sampleId == bytes32(0)) {
      // return default sample id which is setup in the init config
      return HobbyTierConfig.getTierChosenSampleId(LibConstants.DEFAULT_HOBBY_ID, tier);
    } else {
      return sampleId;
    }
  }

  function getHobbyTagChosenSampleId(bytes32 hobbyId, uint8 tier) public view returns (bytes32) {
    bytes32 sampleId = HobbyTierConfig.getTagChosenSampleId(hobbyId, tier);
    if (sampleId == bytes32(0)) {
      // return default sample id which is setup in the init config
      return HobbyTierConfig.getTagChosenSampleId(LibConstants.DEFAULT_HOBBY_ID, tier);
    } else {
      return sampleId;
    }
  }

  function getHobbyTierBySeed(bytes32 hobbyId, bytes32 catId, uint256 randSeed) public view returns (uint8) {
    IWorld world = getWorld();
    uint32 level = Cats.getLevel(catId);
    uint8 currentTier = getHobbyLevelTierConfig(hobbyId, level);
    bytes32 tierRateSampleId = getHobbyTierChosenSampleId(hobbyId, currentTier);
    uint256 length = HobbyTierConfig.lengthTierChosenRange(hobbyId, currentTier);
    uint256 chosenTierIndex;
    uint8 chosenTier;
    if (length == 0) {
      // return default length which is setup in the init config
      length = HobbyTierConfig.lengthTierChosenRange(LibConstants.DEFAULT_HOBBY_ID, currentTier);
      chosenTierIndex = world.getSampleIndex(tierRateSampleId, randSeed, "tier", length);
      chosenTier = HobbyTierConfig.getItemTierChosenRange(LibConstants.DEFAULT_HOBBY_ID, currentTier, chosenTierIndex);
    } else {
      chosenTierIndex = world.getSampleIndex(tierRateSampleId, randSeed, "tier", length);
      chosenTier = HobbyTierConfig.getItemTierChosenRange(hobbyId, currentTier, chosenTierIndex);
    }

    return chosenTier;
  }

  function getHobbyTagBySeed(bytes32 hobbyId, uint8 tier, uint256 randSeed) public view returns (bytes32) {
    IWorld world = getWorld();
    bytes32 tagRateSampleId = getHobbyTagChosenSampleId(hobbyId, tier);
    uint256 length = HobbyTierConfig.lengthTagChosenRange(hobbyId, tier);
    console.log("tag chosen range length", length);
    uint256 tagIndex;
    bytes32 tagId;
    if (length == 0) {
      length = HobbyTierConfig.lengthTagChosenRange(LibConstants.DEFAULT_HOBBY_ID, tier);
      tagIndex = world.getSampleIndex(tagRateSampleId, randSeed, "tag", length);
      tagId = HobbyTierConfig.getItemTagChosenRange(LibConstants.DEFAULT_HOBBY_ID, tier, tagIndex);
    } else {
      tagIndex = world.getSampleIndex(tagRateSampleId, randSeed, "tag", length);
      tagId = HobbyTierConfig.getItemTagChosenRange(hobbyId, tier, tagIndex);
    }
    return tagId;
  }

  function getHobbyTagsBySeed(
    bytes32 hobbyId,
    uint8 tier,
    uint256 randSeed,
    uint32 tagNum
  ) public view returns (bytes32[] memory) {
    require(tagNum >= 1, "tagNum must >= 1 to get tags");
    uint256 length = HobbyTierConfig.lengthTagChosenRange(hobbyId, tier);
    // TODO: if we need default hobby tags
    // if length is zero, use default hobby tags config
    if (length == 0) {
      hobbyId = LibConstants.DEFAULT_HOBBY_ID;
      length = HobbyTierConfig.lengthTagChosenRange(hobbyId, tier);
    }
    // @SampleOpenConfigSystem
    uint256[] memory tagIndices = getWorld().getSampleIndices(
      HobbyTierConfig.getTagChosenSampleId(hobbyId, tier),
      randSeed,
      "tag",
      length,
      tagNum
    );
    bytes32[] memory tagIds = new bytes32[](tagNum);
    for (uint32 i = 0; i < tagNum; i++) {
      tagIds[i] = HobbyTierConfig.getItemTagChosenRange(hobbyId, tier, tagIndices[i]);
    }
    return tagIds;
  }

  function getHobbyRewardItemIndexBySeed(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) public view returns (uint256) {
    bytes32 sampleId = HobbyRewardItemsConfig.getSampleId(hobbyId, tier, tagId);
    IWorld world = getWorld();
    uint256 length = HobbyRewardItemsConfig.lengthItemIds(hobbyId, tier, tagId);
    // Each tag must have at least one reward item
    require(length > 0, "Reward item length under this tier tag must be greater than 0");
    uint256 itemIndex = world.getSampleIndex(sampleId, randSeed, "item", length);
    return itemIndex;
  }

  function getHobbyRewardItemsBySeed(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) public view returns (bytes32[] memory) {
    uint256 itemIndex = getHobbyRewardItemIndexBySeed(hobbyId, tier, tagId, randSeed);
    bytes32 itemId = HobbyRewardItemsConfig.getItemItemIds(hobbyId, tier, tagId, itemIndex);
    uint8 extraRewardNum = HobbyConfig.getExtraRewardNum(hobbyId);
    bytes32[] memory rewardItemIds = new bytes32[](extraRewardNum + 1);
    rewardItemIds[0] = itemId;
    for (uint8 i = 0; i < extraRewardNum; i++) {
      bytes32 extraItemId = HobbyExtraRewardConfig.getItem(hobbyId, tier, tagId, i, itemIndex);
      rewardItemIds[i] = extraItemId;
    }
    return rewardItemIds;
  }
}
