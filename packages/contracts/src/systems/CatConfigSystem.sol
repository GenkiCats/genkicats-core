// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { CatConfig } from "../codegen/Tables.sol";

contract CatConfigSystem is System {
  function setCatConfig(uint32 catLevel, uint32 hungerLimit, uint32 funLimit, uint32 expLimit) public {
    CatConfig.set(catLevel, hungerLimit, funLimit, expLimit);
  }
}
