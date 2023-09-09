// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Shop } from "../codegen/Tables.sol";

contract ShopConfigSystem is System {
  function setupShops(
    bytes32[] memory itemIds,
    uint[] memory coinPrices,
    uint[] memory diamondPrices,
    uint32[] memory unlockLevels,
    uint32[] memory dailyLimits
  ) public {
    for (uint i = 0; i < itemIds.length; i++) {
      Shop.setItemCoinPrice(itemIds[i], coinPrices[i]);
      Shop.setItemDiamondPrice(itemIds[i], diamondPrices[i]);
      Shop.setItemUnlockLevel(itemIds[i], unlockLevels[i]);
      Shop.setItemDailyLimit(itemIds[i], dailyLimits[i]);
    }
  }

  function listItem(bytes32 itemId, uint coinPrice, uint diamondPrice, uint32 unlockLevel) public {
    listItem(itemId, coinPrice, diamondPrice, 0, unlockLevel, 0, 0, 0, 0);
  }

  function listItem(
    bytes32 itemId,
    uint coinPrice,
    uint diamondPrice,
    uint tokenPrice,
    uint32 unlockLevel,
    uint32 dailyLimit,
    uint32 weeklyLimit,
    uint32 monthlyLimit,
    uint32 foreverLimit
  ) public {
    if (coinPrice != 0) {
      Shop.setItemCoinPrice(itemId, coinPrice);
    }
    if (diamondPrice != 0) {
      Shop.setItemDiamondPrice(itemId, diamondPrice);
    }
    if (tokenPrice != 0) {
      Shop.setItemTokenPrice(itemId, tokenPrice);
    }
    if (unlockLevel != 0) {
      Shop.setItemUnlockLevel(itemId, unlockLevel);
    }
    if (dailyLimit != 0) {
      Shop.setItemDailyLimit(itemId, dailyLimit);
    }
    if (weeklyLimit != 0) {
      Shop.setItemWeeklyLimit(itemId, weeklyLimit);
    }
    if (monthlyLimit != 0) {
      Shop.setItemMonthlyLimit(itemId, monthlyLimit);
    }
    if (foreverLimit != 0) {
      Shop.setItemForeverLimit(itemId, foreverLimit);
    }
  }
}
