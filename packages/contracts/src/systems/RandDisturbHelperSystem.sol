// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";

contract RandDisturbHelperSystem is System {
  function getSimpleRandDisturbResult(
    uint256 baseValue,
    uint256 disturbRange,
    uint256 randSeed
  ) public pure returns (uint256) {
    require(disturbRange >= baseValue, "disturbRange must >= baseValue");
    if (randSeed % 2 == 0) {
      return baseValue + (randSeed % disturbRange);
    } else {
      return baseValue - (randSeed % disturbRange);
    }
  }
}
