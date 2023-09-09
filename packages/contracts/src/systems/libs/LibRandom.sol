// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library LibRandom {
  function getSimpleRandDisturbResult(
    uint256 baseValue,
    uint256 disturbRange,
    uint256 randSeed,
    string memory salt
  ) internal pure returns (uint256) {
    randSeed = uint256(keccak256(abi.encodePacked(salt, randSeed)));
    return getSimpleRandDisturbResult(baseValue, disturbRange, randSeed);
  }

  function getSimpleRandDisturbResult(
    uint256 baseValue,
    uint256 disturbRange,
    uint256 randSeed
  ) internal pure returns (uint256) {
    if (disturbRange == 0) {
      return baseValue;
    }
    if (randSeed % 2 == 0) {
      return baseValue + (randSeed % disturbRange);
    } else {
      uint256 decreaseValue = randSeed % disturbRange;
      if (decreaseValue >= baseValue) {
        return 0;
      } else {
        return baseValue - decreaseValue;
      }
    }
  }
}
