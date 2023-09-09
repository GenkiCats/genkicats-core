// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { CatConfig, HobbyBasicConfig, HobbyLevelTierConfig, HobbyTierConfig } from "../codegen/Tables.sol";
import { LibConstants } from "./libs/LibConstants.sol";
import { getWorld } from "./helpers/WorldHelper.sol";

// TODO: sub system only for init designer
contract HobbyConfigSystem is System {
  /**
   * Define the basic setting for hobby
   *
   * @param hungerPetExpRate pet experience conversion rate for when pet consume hunger in 10000 precision
   * @param hungerUserExpRate user experience conversion rate when pet consume hunger in 10000 precision
   */
  function setupHobbyBasicConfig(uint32 hungerPetExpRate, uint32 hungerUserExpRate) public {
    HobbyBasicConfig.set(hungerPetExpRate, hungerUserExpRate);
  }

  /**
   * Define the hobby tier for each level
   *
   * @param tiers the tier for each level
   */
  function setupHobbyLevelTierDefault(uint8[] calldata tiers) public {
    for (uint32 level = 1; level <= tiers.length; level++) {
      uint32 index = level - 1;
      require(tiers[index] > 0, "Invalid tier value");
      HobbyLevelTierConfig.set(LibConstants.DEFAULT_HOBBY_ID, level, tiers[index]);
    }
  }

  /**
   * Define the hobby tier chosen random sample weight config id for each tier
   *
   * @param tier the hobby tier to set, eg. 1
   * @param sampleId the sample config id for the tier, eg. 0x1, must be unique
   * @param samplingMethod 0 for no sample, 1 for simple sample, 2 for alias sample, 3 for prefix sum sample
   * @param indices only used for simple sample and alias sample
   * @param rates only used for alias sample
   * @param accWeights only used for prefix sum sample
   */
  function setupHobbyTierChosenDefault(
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    uint8[] memory tierChoseRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    require(tier > 0, "Invalid tier value");
    HobbyTierConfig.setTierChosenSampleId(LibConstants.DEFAULT_HOBBY_ID, tier, sampleId);
    HobbyTierConfig.setTierChosenRange(LibConstants.DEFAULT_HOBBY_ID, tier, tierChoseRange);
    getWorld().setSampleConfig(sampleId, samplingMethod, indices, rates, accWeights);
  }

  /**
   * Define the hobby tag chosen random sample weight config id for each tier
   *
   * @param tier the hobby tier to set, eg. 1
   * @param sampleId the sample config id for the tier, eg. 0x1, must be unique
   * @param samplingMethod 0 for no sample, 1 for simple sample, 2 for alias sample, 3 for prefix sum sample
   * @param indices only used for simple sample and alias sample
   * @param rates only used for alias sample
   * @param accWeights only used for prefix sum sample
   */
  function setupHobbyTagChosenDefault(
    uint8 tier,
    bytes32 sampleId,
    uint8 samplingMethod,
    bytes32[] memory tagChosenRange,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    HobbyTierConfig.setTagChosenSampleId(LibConstants.DEFAULT_HOBBY_ID, tier, sampleId);
    HobbyTierConfig.setTagChosenRange(LibConstants.DEFAULT_HOBBY_ID, tier, tagChosenRange);
    getWorld().setSampleConfig(sampleId, samplingMethod, indices, rates, accWeights);
  }
}
