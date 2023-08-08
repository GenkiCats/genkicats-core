// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Shop } from "../codegen/Tables.sol";

contract ShopConfigSystem is System {
  function listBasicItem(bytes32 itemId, uint coinPrice, uint32 unlockLevel) public {
    if (coinPrice != 0) {
      Shop.setItemCoinPrice(itemId, coinPrice);
    }
    if (unlockLevel != 0) {
      Shop.setItemUnlockLevel(itemId, unlockLevel);
    }
  }

  function listBasicItems(
    bytes32[] calldata itemIds,
    uint[] calldata coinPrices,
    uint32[] calldata unlockLevels
  ) public {
    for (uint i = 0; i < itemIds.length; i++) {
      listBasicItem(itemIds[i], coinPrices[i], unlockLevels[i]);
    }
  }

  function listAdvancedItem(bytes32 itemId, uint diamondPrice, uint32 unlockLevel) public {
    if (diamondPrice != 0) {
      Shop.setItemDiamondPrice(itemId, diamondPrice);
    }
    if (unlockLevel != 0) {
      Shop.setItemUnlockLevel(itemId, unlockLevel);
    }
  }

  function listAdvancedItems(
    bytes32[] calldata itemIds,
    uint[] calldata diamondPrices,
    uint32[] calldata unlockLevels
  ) public {
    for (uint i = 0; i < itemIds.length; i++) {
      listAdvancedItem(itemIds[i], diamondPrices[i], unlockLevels[i]);
    }
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
