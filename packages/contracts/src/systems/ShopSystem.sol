// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
// import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { Shop, UserStatus, Address2User, ItemConfig, UserItems, GlobalAddressConfig } from "../codegen/Tables.sol";

import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";

import { IWorld } from "../codegen/world/IWorld.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

// import {addItem, decCoin, decDiamond} from "./QuantitiHelperSystem.sol";

contract ShopSystem is System {
  function buyItem(uint256 itemId, uint32 itemNum, uint32 currencyCode) public {
    // get user id
    bytes32 userId = getUserId(_msgSender());
    // get world
    IWorld world = getWorld();

    // check if user has enough money
    // if check pass, consume money
    uint256 price;
    uint userBalance;
    if (currencyCode == 0) {
      price = Shop.getItemCoinPrice(itemId);
      userBalance = UserStatus.getCoinBalance(userId);
      world.decCoin(userId, itemNum * price);
    } else if (currencyCode == 1) {
      price = Shop.getItemDiamondPrice(itemId);
      userBalance = UserStatus.getDiamondBalance(userId);
      world.decDiamond(userId, itemNum * price);
    } else if (currencyCode == 2) {
      price = Shop.getItemTokenPrice(itemId);
      // only when sender address has enough tokens can buy
      address tokenAddress = GlobalAddressConfig.get(keccak256("main_token"));
      // all coin consumed in shop will be locked in the world contract permanently
      IERC20(tokenAddress).transferFrom(_msgSender(), address(this), itemNum * price);
    } else {
      revert("invalid currency code");
    }

    // check if user has enought expereince

    uint32 expRequired = Shop.getItemUnlockLevel(itemId);
    if (expRequired > 0) {
      uint32 userExp = UserStatus.getExp(userId);
      require(userExp >= expRequired, "not enough experience");
    }

    // check if user reach purchase limit
    // buy specific item
    bytes32 eventId = keccak256(abi.encode("buyItem", itemId));

    // check daily buy limit
    uint32 dailyLimit = Shop.getItemDailyLimit(itemId);
    // @PeriodEventsSystem
    world.finishDailyEvents(userId, eventId, itemNum, dailyLimit);

    // check weekly buy limit
    uint32 weeklyLimit = Shop.getItemWeeklyLimit(itemId);
    // @PeriodEventsSystem
    world.finishWeeklyEvents(userId, eventId, itemNum, weeklyLimit);

    // check montly buy limit
    // notice that month is 30 days, not exactly 1 month
    uint32 monthlyLimit = Shop.getItemMonthlyLimit(itemId);
    // @PeriodEventsSystem
    world.finishMonthlyEvents(userId, eventId, itemNum, weeklyLimit);

    // check forever buy limit
    uint32 foreverLimit = Shop.getItemForeverLimit(itemId);
    // @PeriodEventsSystem
    world.finishForeverEvents(userId, eventId, itemNum, foreverLimit);

    // handle items
    // auto check max hold quantity inside addItem
    world.addItem(userId, itemId, itemNum);
  }
}
