// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IShopConfigSystem {
  function listBasicItem(uint itemId, uint coinPrice, uint32 unlockLevel) external;

  function listBasicItems(uint[] calldata itemIds, uint[] calldata coinPrices, uint32[] calldata unlockLevels) external;

  function listAdvancedItem(uint itemId, uint diamondPrice, uint32 unlockLevel) external;

  function listAdvancedItems(
    uint[] calldata itemIds,
    uint[] calldata diamondPrices,
    uint32[] calldata unlockLevels
  ) external;

  function listItem(
    uint itemId,
    uint coinPrice,
    uint diamondPrice,
    uint tokenPrice,
    uint32 unlockLevel,
    uint32 dailyLimit,
    uint32 weeklyLimit,
    uint32 monthlyLimit,
    uint32 foreverLimit
  ) external;
}