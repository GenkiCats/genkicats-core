// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserLevelConfig } from "../codegen/Tables.sol";

contract UserLevelConfigSystem is System {
  function setUserLevelConfig(uint32 userLevel, uint32 expLimit) public {
    UserLevelConfig.set(userLevel, expLimit);
  }
}
