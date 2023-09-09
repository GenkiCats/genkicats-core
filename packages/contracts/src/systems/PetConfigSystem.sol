// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { CatConfig, CatBornStatusConfig } from "../codegen/Tables.sol";

contract PetConfigSystem is System {
  function setupCatConfig(
    uint32 hungerConsumeRate,
    uint32 funConsumeRate,
    uint32 baseDropRate,
    uint32 baseHungerCoinRate,
    uint256 starvingStartTime,
    uint32 foreverFriendshipLevel,
    uint32 funLimit,
    uint32 cleanLimit
  ) public {
    CatConfig.set(
      hungerConsumeRate,
      funConsumeRate,
      baseDropRate,
      baseHungerCoinRate,
      starvingStartTime,
      foreverFriendshipLevel,
      funLimit,
      cleanLimit
    );
  }

  function setupCatBornStatusConfig(uint32 hunger, uint32 fun, uint32 clean) public {
    CatBornStatusConfig.set(hunger, fun, clean);
  }
}
