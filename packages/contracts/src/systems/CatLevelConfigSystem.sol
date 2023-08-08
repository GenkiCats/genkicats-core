// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { CatLevelConfig } from "../codegen/Tables.sol";

contract CatLevelConfigSystem is System {
  function setCatLevelConfig(
    uint32 catLevel,
    uint32 hungerLimit,
    uint32 funLimit,
    uint32 expLimit,
    uint32 coinBase
  ) public {
    CatLevelConfig.set(catLevel, hungerLimit, funLimit, expLimit, coinBase);
  }
}
