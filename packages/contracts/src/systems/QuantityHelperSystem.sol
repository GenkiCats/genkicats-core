// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserStatus, UserItems, ItemConfig } from "../codegen/Tables.sol";
import { CatLevelConfig, UserLevelConfig, Cats } from "../codegen/Tables.sol";

import { getWorld } from "./helpers/WorldHelper.sol";
import { LibPet } from "./libs/LibPet.sol";

// sub system
contract QuantityHelperSystem is System {
  uint32 constant MAX_LEVEL = 999;

  // Notice: even if the itemId does not exist, this function will also work
  function addItem(bytes32 userId, bytes32 itemId, uint32 quantity) public {
    // if itemId is 0 or quantity is 0, it means no item
    if (itemId == bytes32(0) || quantity == 0) {
      return;
    }
    uint32 currentQuantity = UserItems.getItemNum(userId, itemId);
    uint32 maxItemQuantity = ItemConfig.getMaxItemQuantity(itemId);
    uint32 newQuantity = currentQuantity + quantity;
    // if maxItemQuantity is 0, it means no limit
    if (maxItemQuantity > 0) {
      require(newQuantity <= maxItemQuantity, "exceed max item quantity");
    }
    UserItems.set(userId, itemId, newQuantity, 0);
  }

  function decItem(bytes32 userId, bytes32 itemId, uint32 quantity) public {
    // if itemId is 0 or quantity is 0, it means no change
    if (itemId == bytes32(0) || quantity == 0) {
      return;
    }
    uint32 currentQuantity = UserItems.getItemNum(userId, itemId);
    uint32 newQuantity = currentQuantity - quantity;
    require(newQuantity >= 0, "not enough item");
    UserItems.set(userId, itemId, newQuantity, 0);
  }

  function addCoin(bytes32 userId, uint256 quantity) public {
    uint coinBalance = UserStatus.getCoinBalance(userId);
    UserStatus.setCoinBalance(userId, coinBalance + quantity);
  }

  function decCoin(bytes32 userId, uint256 quantity) public {
    uint coinBalance = UserStatus.getCoinBalance(userId);
    uint newCoinBalance = coinBalance - quantity;
    require(newCoinBalance >= 0, "not enough coin");
    UserStatus.setCoinBalance(userId, newCoinBalance);
  }

  function addDiamond(bytes32 userId, uint256 quantity) public {
    uint diamondBalance = UserStatus.getDiamondBalance(userId);
    UserStatus.setDiamondBalance(userId, diamondBalance + quantity);
  }

  function decDiamond(bytes32 userId, uint256 quantity) public {
    uint diamondBalance = UserStatus.getDiamondBalance(userId);
    uint newDiamondBalance = diamondBalance - quantity;
    require(newDiamondBalance >= 0, "not enough diamond");
    UserStatus.setDiamondBalance(userId, newDiamondBalance);
  }

  function addUserExp(bytes32 userId, uint32 exp) public {
    uint32 level = UserStatus.getLevel(userId);
    uint32 currentExp = UserStatus.getExp(userId);
    exp += currentExp;
    uint32 expLimit = UserLevelConfig.get(level);
    if (expLimit == 0) {
      // max level
      UserStatus.setExp(userId, exp);
      return;
    }
    if (exp >= expLimit) {
      uint32 leftExp = exp - expLimit;
      for (uint32 i = level + 1; i < MAX_LEVEL; i++) {
        expLimit = UserLevelConfig.get(i);
        if (leftExp < expLimit) {
          UserStatus.setExp(userId, leftExp);
          UserStatus.setLevel(userId, i);
        } else {
          leftExp = leftExp - expLimit;
        }
      }
    }
  }

  function addCatExp(bytes32 catId, uint32 exp) public {
    uint32 level = Cats.getLevel(catId);
    uint32 currentExp = Cats.getExp(catId);
    exp += currentExp;
    uint32 expLimit = CatLevelConfig.getExpLimit(level);
    if (expLimit == 0) {
      // max level
      Cats.setExp(catId, exp);
      return;
    }

    if (exp >= expLimit) {
      uint32 leftExp = exp - expLimit;
      uint32 oldHungerLimit = CatLevelConfig.getHungerLimit(level);
      for (uint32 i = level + 1; i < MAX_LEVEL; i++) {
        expLimit = CatLevelConfig.getExpLimit(i);
        if (leftExp < expLimit) {
          Cats.setExp(catId, leftExp);
          Cats.setLevel(catId, i);
        } else {
          leftExp = leftExp - expLimit;
        }
      }
      LibPet.afterCatHungerLimitUpdate(catId, oldHungerLimit);
    }
  }
}
