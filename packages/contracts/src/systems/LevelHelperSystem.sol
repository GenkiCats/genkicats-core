// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { CatLevelConfig, UserLevelConfig } from "../codegen/Tables.sol";

contract LevelHelperSystem is System {
  uint32 constant MAX_LEVEL = 999;

  function calculateLevel(uint32 level, uint32 exp, uint8 target) public view returns (uint32) {
    uint32 expLimit;
    if (target == 0) {
      expLimit = UserLevelConfig.get(level);
    } else if (target == 1) {
      expLimit = CatLevelConfig.getExpLimit(level);
    } else {
      revert("invalid level calculate target");
    }

    if (exp < expLimit) {
      return level;
    } else {
      uint32 leftExp = exp - expLimit;
      for (uint32 i = level + 1; i < MAX_LEVEL; i++) {
        if (target == 0) {
          expLimit = UserLevelConfig.get(i);
        } else if (target == 1) {
          expLimit = CatLevelConfig.getExpLimit(i);
        } else {
          revert("invalid level calculate target");
        }
        if (leftExp < expLimit) {
          return i;
        } else {
          leftExp = leftExp - expLimit;
        }
      }
    }
  }
}
