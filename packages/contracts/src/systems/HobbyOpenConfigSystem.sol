// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { HobbyConfig, HobbyBasicConfig, HobbyRandomSourceConfig, HobbyLevelTierConfig, HobbyTierConfig, HobbyRewardItemsConfig, HobbyExtraRewardConfig, HobbyExtraStepsConfig, SampleMethodConfig } from "../codegen/Tables.sol";
import { MetaConfig } from "../codegen/Tables.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract HobbyOpenConfigSystem is System {
  /**
   * Hobby Basic Config (Required)
   */

  function setupHobbyConfig(
    string memory hobbyName,
    string memory uri,
    uint8 playerChosenTagNum,
    uint32 hungerConsumptionRate,
    uint8 extraRewardNum,
    bool hasExtraSteps,
    bytes32 hobbyAttractiveItem,
    bytes32[] memory requiredItems,
    uint32 delayBlocks,
    bool strictRandom
  ) public {
    bytes32 hobbyId = bytes32(bytes(hobbyName));
    require(hobbyId != bytes32(0), "invalid hobby name"); // avoid conflict with default config id
    require(
      HobbyConfig.getDesigner(hobbyId) == _msgSender() || HobbyConfig.getDesigner(hobbyId) == address(0),
      "only designer can set hobby config"
    );
    require(hungerConsumptionRate >= 1, "hunger consumption rate too small");
    require(hungerConsumptionRate <= 1666, "hunger consumption rate too large");
    require(delayBlocks >= 1, "delay blocks must be greater than 0");

    // when tagChooseRange is zero, no tag required to be chosen for this hobby
    HobbyConfig.setPlayerChosenTagNum(hobbyId, playerChosenTagNum);

    HobbyConfig.setHungerConsumptionRate(hobbyId, hungerConsumptionRate);
    HobbyConfig.setExtraRewardNum(hobbyId, extraRewardNum);
    HobbyConfig.setHasExtraSteps(hobbyId, hasExtraSteps);
    HobbyConfig.setHobbyAttractiveItem(hobbyId, hobbyAttractiveItem);
    HobbyConfig.setRequiredItems(hobbyId, requiredItems);

    HobbyRandomSourceConfig.set(hobbyId, strictRandom, delayBlocks);

    HobbyConfig.setDesigner(hobbyId, _msgSender());

    MetaConfig.set(hobbyId, hobbyName, uri);
  }

  /**
   * Hobby Tiers times Config (Required)
   */

  function setupHobbyTierTimes(
    bytes32 hobbyId,
    uint8[] memory tiers,
    uint256[] memory baseTimes,
    uint256[] memory baseRestTimes
  ) external {
    for (uint8 i = 0; i < tiers.length; i++) {
      setHobbyTierTime(hobbyId, tiers[i], baseTimes[i], baseRestTimes[i]);
    }
  }

  function setHobbyTierTime(bytes32 hobbyId, uint8 tier, uint256 baseTime, uint256 baseRestTime) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can set hobby tier");
    require(tier >= 1, "tier must be greater than 0");
    require(baseTime >= 600, "base time must be greater than 10 minutes");
    require(baseRestTime >= 600, "rest time must be greater than 10 minutes");
    HobbyTierConfig.setBaseTime(hobbyId, tier, baseTime);
    HobbyTierConfig.setBaseRestTime(hobbyId, tier, baseRestTime);
  }

  /**
   * Customize Hobby Tiers (Optional)
   */

  function setHobbyTierChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    uint8[] memory tierChosenRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can set hobby reward tag rate");
    require(tier >= 1, "Tier must be greater than 0");
    HobbyTierConfig.setTierChosenRange(hobbyId, tier, tierChosenRange);
    IWorld world = getWorld();
    HobbyTierConfig.setTierChosenSampleId(hobbyId, tier, sampleId);
    world.setSampleConfig(sampleId, samplingMethod, indices, rates, accWeights);
  }

  function setHobbyTierChosenSampleIds(bytes32 hobbyId, uint8[] calldata tiers, bytes32[] calldata sampleIds) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");
    require(tiers.length == sampleIds.length, "Invalid sample id length");
    for (uint32 i = 0; i < tiers.length; i++) {
      HobbyTierConfig.setTierChosenSampleId(hobbyId, tiers[i], sampleIds[i]);
    }
  }

  function setHobbyTierChosenRange(bytes32 hobbyId, uint8 tier, uint8[] calldata tierChosenRange) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");
    require(tier >= 1, "Tier must be greater than 0");
    HobbyTierConfig.setTierChosenRange(hobbyId, tier, tierChosenRange);
  }

  function setHobbyLevelTierConfig(bytes32 hobbyId, uint8[] calldata tiers) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");

    for (uint32 level = 1; level <= tiers.length; level++) {
      uint32 index = level - 1;
      require(tiers[index] > 0, "Invalid tier value");
      HobbyLevelTierConfig.set(hobbyId, level, tiers[index]);
    }
  }

  /**
   * Customize Hobby Tags (Optional)
   */

  function setHobbyTagChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    bytes32[] memory tagChosenRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");
    require(tier >= 1, "Tier must be greater than 0");
    HobbyTierConfig.setTagChosenRange(hobbyId, tier, tagChosenRange);
    IWorld world = getWorld();
    HobbyTierConfig.setTagChosenSampleId(hobbyId, tier, sampleId);
    world.setSampleConfig(sampleId, samplingMethod, indices, rates, accWeights);
  }

  function setHobbyTagChosenRange(bytes32 hobbyId, uint8 tier, bytes32[] calldata tagChosenRange) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");
    require(tier >= 1, "Tier must be greater than 0");
    HobbyTierConfig.setTagChosenRange(hobbyId, tier, tagChosenRange);
  }

  function setHobbyTagChosenSampleIds(bytes32 hobbyId, uint8[] calldata tiers, bytes32[] calldata sampleIds) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "Only designer can set hobby config");
    require(tiers.length == sampleIds.length, "Invalid sample id length");
    for (uint32 i = 0; i < tiers.length; i++) {
      require(tiers[i] >= 1, "Tier must be greater than 0");
      HobbyTierConfig.setTagChosenSampleId(hobbyId, tiers[i], sampleIds[i]);
    }
  }

  /**
   * Hobby Reward Items Config (Required)
   */

  function setHobbyRewardItems(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32[] calldata itemIds) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    HobbyRewardItemsConfig.setItemIds(hobbyId, tier, tagId, itemIds);
  }

  function setHobbyRewardSampleId(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32 sampleId) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    HobbyRewardItemsConfig.setSampleId(hobbyId, tier, tagId, sampleId);
  }

  function setupHobbyRewardItemChosenConfig(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    bytes32 sampleId,
    uint8 samplingMethod,
    bytes32[] memory itemIds,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can set hobby reward item rate");
    IWorld world = getWorld();
    HobbyRewardItemsConfig.setSampleId(hobbyId, tier, tagId, sampleId);
    HobbyRewardItemsConfig.setItemIds(hobbyId, tier, tagId, itemIds);
    world.setSampleConfig(sampleId, samplingMethod, indices, rates, accWeights);
  }

  /**
   * Reward Step Config (Optional)
   */

  function setHobbySteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32[] calldata extraSteps) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    require(
      extraSteps.length == HobbyRewardItemsConfig.lengthItemIds(hobbyId, tier, tagId),
      "extraSteps length must be equal to itemIds length"
    );
    HobbyExtraStepsConfig.set(hobbyId, tier, tagId, extraSteps);
  }

  function addHobbyRewardSteps(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint32 extraStep) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    HobbyExtraStepsConfig.push(hobbyId, tier, tagId, extraStep);
  }

  /**
   * Extra Reward Config (Optional)
   */

  function setHobbyExtraReward(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint8 extraIndex,
    bytes32[] calldata itemIds
  ) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    require(tier >= 1, "tier must be greater than 0");
    require(
      HobbyRewardItemsConfig.lengthItemIds(hobbyId, tier, tagId) == itemIds.length,
      "extra itemIds length must be equal to default itemIds length"
    );
    HobbyExtraRewardConfig.set(hobbyId, tier, tagId, extraIndex, itemIds);
  }

  function addHobbyExtraReward(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint8 extraIndex, bytes32 itemId) public {
    require(HobbyConfig.getDesigner(hobbyId) == _msgSender(), "only designer can edit hobby config");
    HobbyExtraRewardConfig.push(hobbyId, tier, tagId, extraIndex, itemId);
  }
}
