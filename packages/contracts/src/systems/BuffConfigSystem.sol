// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { BuffTypeConfig, BuffConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

// non public system
//TODO: design buff config open config pattern while keep the balance of the game
contract BuffConfigSystem is System {
  /**
   * Setup buff type config
   *
   * @param buffTypes buff types
   * @param attributes buff attributes
   *
   * Same type buff will replaced by the last one
   *
   * buff type 0: multiply the reward drop rate of pet, eg. attribute 20000 means base drop rate  * 200%
   */
  function setupBuffTypeConfig(uint32[] memory buffTypes, uint256[] memory attributes) public {
    for (uint i = 0; i < buffTypes.length; i++) {
      BuffTypeConfig.set(buffTypes[i], attributes[i], new uint256[](0));
    }
  }

  /**
   * Set the extra attributes of buff
   * @param buffType buff type
   * @param extraAttributes extra attributes in array
   */
  function setBuffTypeExtraAttributes(uint32 buffType, uint256[] memory extraAttributes) public {
    BuffTypeConfig.setExtraAttributes(buffType, extraAttributes);
  }

  function setupBuffConfig(
    bytes32[] memory buffIds,
    uint32[] memory buffTypes,
    uint256[] memory buffValues,
    uint256[] memory durations
  ) public {
    for (uint i = 0; i < buffIds.length; i++) {
      BuffConfig.set(buffIds[i], buffTypes[i], buffValues[i], durations[i], new uint256[](0));
    }
  }

  function setBuffConfigExtraValues(bytes32 buffId, uint256[] memory extraValues) public {
    BuffConfig.setBuffExtraValues(buffId, extraValues);
  }
}
