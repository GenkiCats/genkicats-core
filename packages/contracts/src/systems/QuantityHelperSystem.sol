// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserStatus, UserItems, ItemConfig } from "../codegen/Tables.sol";

contract QuantityHelperSystem is System {
  // Notice: even if the itemId does not exist, this function will also work
  function addItem(bytes32 userId, uint256 itemId, uint32 quantity) public {
    uint32 currentQuantity = UserItems.getItemNum(userId, itemId);
    uint32 maxItemQuantity = ItemConfig.getMaxItemQuantity(itemId);
    uint32 newQuantity = currentQuantity + quantity;
    // if maxItemQuantity is 0, it means no limit
    if (maxItemQuantity > 0) {
      require(newQuantity <= maxItemQuantity, "exceed max item quantity");
    }
    UserItems.set(userId, itemId, newQuantity, 0);
  }

  function decItem(bytes32 userId, uint256 itemId, uint32 quantity) public {
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

  function addExp(bytes32 userId, uint32 quantity) public {
    uint32 exp = UserStatus.getExp(userId);
    UserStatus.setExp(userId, exp + quantity);
  }
}
