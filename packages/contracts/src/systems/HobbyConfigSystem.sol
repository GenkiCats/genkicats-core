// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { HobbyConfig, HobbyRandomSourceConfig, HobbyTierConfig, HobbyRewardTagsConfig, HobbyRewardItemsConfig, HobbyExtraRewardConfig, HobbyRewardStepsConfig, SampleMethodConfig } from "../codegen/Tables.sol";
import { MetaConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract HobbyConfigSystem is System {
  function createHobby(string memory hobbyName, string memory uri) public {
    bytes32 hobbyId = keccak256(abi.encodePacked(hobbyName));
    require(HobbyConfig.getCreator(hobbyId) == address(0), "hobby already exists");

    HobbyConfig.setCreator(hobbyId, _msgSender());
    MetaConfig.set(hobbyId, hobbyName, uri);
  }

  function setHobbyConfig(
    bytes32 hobbyId,
    uint8 tagChosenRange,
    uint8 tierNum,
    uint8 extraRewardNum,
    bool hasExtraSteps,
    bytes32 hobbyAttractiveItem,
    bytes32[] memory requiredItems,
    uint32 delayBlocks,
    bool strictRandom
  ) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can set hobby config");
    require(delayBlocks >= 1, "delay blocks must be greater than 0");

    HobbyConfig.setTagChosenRange(hobbyId, tagChosenRange);
    HobbyConfig.setTierNum(hobbyId, tierNum);
    HobbyConfig.setExtraRewardNum(hobbyId, extraRewardNum);
    HobbyConfig.setHasExtraSteps(hobbyId, hasExtraSteps);
    HobbyConfig.setHobbyAttractiveItem(hobbyId, hobbyAttractiveItem);
    HobbyConfig.setRequiredItems(hobbyId, requiredItems);

    HobbyRandomSourceConfig.set(hobbyId, strictRandom, delayBlocks);
  }

  function setHobbyTier(
    bytes32 hobbyId,
    uint8 tier,
    uint256 baseTime,
    uint256 baseRestTime,
    uint32 hungerConsumptionRate
  ) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can set hobby tier");
    require(tier >= 1, "tier must be greater than 0");
    require(baseTime >= 600, "base time must be greater than 10 minutes");
    require(hungerConsumptionRate >= 1000, "hunger consumption rate must be greater than 0.1");
    require(hungerConsumptionRate <= 10000, "hunger consumption rate must be less than 1");
    require(baseTime >= (hungerConsumptionRate * 6) / 10, "hobby time must >= hungerConsumptionRate * 1 minute");
    require(baseRestTime >= (hungerConsumptionRate * 6) / 10, "rest time must >=  hungerConsumptionRate * 1 minute");

    HobbyTierConfig.set(hobbyId, tier, baseTime, baseRestTime, hungerConsumptionRate);
  }

  function getRewardRateSampleId(bytes32 hobbyId, uint8 level) public pure returns (bytes32) {
    string memory keyword;
    if (level == 0) {
      keyword = "rewardTierRate";
    } else if (level == 1) {
      keyword = "rewardTagRate";
    } else if (level == 2) {
      keyword = "rewardItemRate";
    } else {
      revert("invalid reward rate level");
    }
    bytes32 sampleId = keccak256(abi.encodePacked(hobbyId, keyword));
    return sampleId;
  }

  function getRewardTierRateSampleId(bytes32 hobbyId) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(hobbyId, "rewardTierRate"));
  }

  function getRewardTagRateSampleId(bytes32 hobbyId, uint8 tier) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(hobbyId, tier, "rewardTagRate"));
  }

  function getRewardItemRateSampleId(bytes32 hobbyId, uint8 tier, bytes32 tagId) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(hobbyId, tier, tagId, "rewardItemRate"));
  }

  // tiers always start from 0, 0 is the lowest tier
  function setHobbyRewardTierRate(bytes32 hobbyId, uint8 samplingMethod) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can set hobby reward tier rate");
    SampleMethodConfig.set(getRewardTierRateSampleId(hobbyId), samplingMethod);
  }

  function getHobbyRewardTierBySeed(IWorld world, bytes32 hobbyId, uint256 randSeed) public view returns (uint8) {
    bytes32 tierRateSampleId = getRewardTierRateSampleId(hobbyId);
    // tier start from 1
    // TODO: check if this works correct
    uint8 tier = uint8(world.getSampleIndex(tierRateSampleId, randSeed, HobbyConfig.getTierNum(hobbyId)) + 1);
    return tier;
  }

  function setHobbyRewardTags(bytes32 hobbyId, uint8 tier, bytes32[] calldata tagIds, uint8 samplingMethod) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    HobbyRewardTagsConfig.set(hobbyId, tier, tagIds);
    SampleMethodConfig.set(getRewardTagRateSampleId(hobbyId, tier), samplingMethod);
  }

  function getHobbyRewardTagBySeed(
    IWorld world,
    bytes32 hobbyId,
    uint8 tier,
    uint256 randSeed
  ) public view returns (bytes32) {
    bytes32 tagRateSampleId = getRewardTagRateSampleId(hobbyId, tier);
    uint256 tagIndex = world.getSampleIndex(tagRateSampleId, randSeed, HobbyRewardTagsConfig.length(hobbyId, tier));
    bytes32 tagId = HobbyRewardTagsConfig.getItem(hobbyId, tier, tagIndex);
    (hobbyId, tier, tagIndex);
    return tagId;
  }

  function getHobbyRewardTagsBySeed(
    IWorld world,
    bytes32 hobbyId,
    uint8 tier,
    uint256 randSeed,
    uint32 tagNum
  ) public view returns (bytes32[] memory) {
    require(tagNum >= 1, "tagNum must be greater than or equal to 1");
    require(
      tagNum <= HobbyRewardTagsConfig.length(hobbyId, tier),
      "tagNum must be less than or equal to the length of TagIds"
    );

    bytes32 tagRateSampleId = getRewardTagRateSampleId(hobbyId, tier);

    uint256 tagIndex = world.getSampleIndex(tagRateSampleId, randSeed, HobbyRewardTagsConfig.length(hobbyId, tier));

    bytes32[] memory tagIds = new bytes32[](tagNum);
    for (uint32 i = 0; i < tagNum; i++) {
      tagIndex = (tagIndex + 1) % HobbyRewardTagsConfig.length(hobbyId, tier);
      tagIds[i] = HobbyRewardTagsConfig.getItem(hobbyId, tier, tagIndex);
    }
    return tagIds;
  }

  function setHobbyRewardItems(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    bytes32[] calldata itemIds,
    uint8 samplingMethod
  ) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    HobbyRewardItemsConfig.set(hobbyId, tier, tagId, itemIds);
    SampleMethodConfig.set(getRewardRateSampleId(hobbyId, 2), samplingMethod);
  }

  function getHobbyRewardItemIndexBySeed(
    IWorld world,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) public view returns (uint256) {
    bytes32 itemRateSampleId = getRewardItemRateSampleId(hobbyId, tier, tagId);
    uint256 itemIndex = world.getSampleIndex(
      itemRateSampleId,
      randSeed,
      HobbyRewardItemsConfig.length(hobbyId, tier, tagId)
    );
    return itemIndex;
  }

  function getHobbyRewardItemsBySeed(
    IWorld world,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 randSeed
  ) public view returns (bytes32[] memory) {
    uint256 itemIndex = getHobbyRewardItemIndexBySeed(world, hobbyId, tier, tagId, randSeed);
    bytes32 itemId = HobbyRewardItemsConfig.getItem(hobbyId, tier, tagId, itemIndex);
    uint8 extraRewardNum = HobbyConfig.getExtraRewardNum(hobbyId);
    bytes32[] memory rewardItemIds = new bytes32[](extraRewardNum + 1);
    rewardItemIds[0] = itemId;
    for (uint8 i = 0; i < extraRewardNum; i++) {
      bytes32 extraItemId = HobbyExtraRewardConfig.getItem(hobbyId, tier, tagId, i, itemIndex);
      rewardItemIds[i] = extraItemId;
    }
    return rewardItemIds;
  }

  function setHobbyExtraReward(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint8 extraIndex,
    bytes32[] calldata itemIds
  ) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    require(
      HobbyRewardItemsConfig.length(hobbyId, tier, tagId) == itemIds.length,
      "extra itemIds length must be equal to default itemIds length"
    );
    HobbyExtraRewardConfig.set(hobbyId, tier, tagId, extraIndex, itemIds);
  }

  function addHobbyExtraReward(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint8 extraIndex, bytes32 itemId) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    HobbyExtraRewardConfig.push(hobbyId, tier, tagId, extraIndex, itemId);
  }

  function setHobbyRewardSteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32[] calldata extraSteps) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    require(
      extraSteps.length == HobbyRewardItemsConfig.length(hobbyId, tier, tagId),
      "extraSteps length must be equal to itemIds length"
    );
    HobbyRewardStepsConfig.set(hobbyId, tier, tagId, extraSteps);
  }

  function addHobbyRewardSteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32 extraStep) public {
    require(HobbyConfig.getCreator(hobbyId) == _msgSender(), "only creator can edit hobby config");
    HobbyRewardStepsConfig.push(hobbyId, tier, tagId, extraStep);
  }
}
