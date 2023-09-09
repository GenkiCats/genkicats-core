// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserLevelConfig, CatLevelConfig, CatFriendshipLevelConfig } from "../codegen/Tables.sol";

// non open system
contract LevelConfigSystem is System {
  function setUserLevelConfig(uint32 userLevel, uint32 expLimit) public {
    UserLevelConfig.set(userLevel, expLimit);
  }

  function setupUserLevelConfig(uint32[] memory userLevels, uint32[] memory expLimits) public {
    for (uint i = 0; i < userLevels.length; i++) {
      setUserLevelConfig(userLevels[i], expLimits[i]);
    }
  }

  function setUserLevelConfigs(uint32[] calldata userLevels, uint32[] calldata expLimits) public {
    for (uint i = 0; i < userLevels.length; i++) {
      setUserLevelConfig(userLevels[i], expLimits[i]);
    }
  }

  function setCatLevelConfig(uint32 catLevel, uint32 hungerLimit, uint32 expLimit) public {
    CatLevelConfig.set(catLevel, hungerLimit, expLimit);
  }

  function setupCatLevelConfig(
    uint32[] memory catLevels,
    uint32[] memory hungerLimits,
    uint32[] memory expLimits
  ) public {
    for (uint i = 0; i < catLevels.length; i++) {
      setCatLevelConfig(catLevels[i], hungerLimits[i], expLimits[i]);
    }
  }

  function setCatFriendshipLevelConfig(uint32 friendshipLevel, uint32 expLimit, uint32 starvingTimeLimit) public {
    CatFriendshipLevelConfig.set(friendshipLevel, expLimit, starvingTimeLimit);
  }

  function setupCatFriendshipLevelConfig(
    uint32[] memory friendshipLevels,
    uint32[] memory expLimits,
    uint32[] memory starvingTimeLimits
  ) public {
    for (uint i = 0; i < friendshipLevels.length; i++) {
      setCatFriendshipLevelConfig(friendshipLevels[i], expLimits[i], starvingTimeLimits[i]);
    }
  }
}
