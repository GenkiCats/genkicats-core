// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";

contract LevelConfigSystem is System {
  //TODO: add level config
  function calculateUserLevel(uint32 experience) public pure returns (uint32) {
    uint32 tempLevel = experience / 150;
    return tempLevel;
  }

  function calculateCatLevel(uint32 experience) public pure returns (uint32) {
    uint32 tempLevel = experience / 100;
    return tempLevel;
  }
}
