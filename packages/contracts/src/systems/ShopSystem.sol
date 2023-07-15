// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
// import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { Shop, UserStatus, EventTimes, Address2User, ItemConfig, UserItems} from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";
import {GenkiToken} from "./tokens/GenkiToken.sol";


contract ShopSystem is System {


  function buyItem(bytes32 itemId, uint32 itemNum, uint32 currencyCode) public {
    // get user id
    bytes32 userId = Address2User.get(_msgSender());

    // check if user has enough money
    uint256 price;
    uint userBalance;
    if (currencyCode == 0) {
      price = Shop.getItemCoinPrice(itemId);
      userBalance = UserStatus.getCoinBalance(userId);
    } else if (currencyCode == 1) {
      price = Shop.getItemDiamondPrice(itemId);
      userBalance = UserStatus.getDiamondBalance(userId);
    } else if (currencyCode == 2) {
      price = Shop.getItemTokenPrice(itemId);
      // only when sender address has enough tokens can buy
      userBalance = GenkiToken.balanceOf(_msgSender());
    } else {
      revert("invalid currency code");
    }
    uint totalAmount = itemNum * price;
    require(userBalance >= totalAmount, "not enough money");
    // check if user has enought expereince
    uint32 expRequired = Shop.getItemUnlockExp(itemId);
    if (expRequired > 0) {
      uint32 userExp = UserStatus.getExperience(userId);
      require(userExp >= expRequired, "not enough experience");
    }
    

  // check if user reach buy limit

   // get user timezone offset
    int32 timezoneOffset = UserStatus.getTimezoneOffset(userId);
    uint256 timezoneTimestamp = block.timestamp + timezoneOffset;

    // buy specific item
    bytes32 eventId = keccak256(abi.encode("buyItem", itemId)); 

    // check daily buy limit
    uint32 dailyBuyLimit = Shop.getItemDailyBuyLimit(itemId);
    if (dailyBuyLimit > 0) {
      uint32 dayNum = timezoneTimestamp % 86400;
      uint32 buyTimes = EventTimes.get(userId, eventId, 0, dayNum);
      require(buyTimes + itemNum <= dailyBuyLimit, "reach daily purchase limit");
    }

    // check weekly buy limit
    uint32 weeklyBuyLimit = Shop.getItemWeeklyBuyLimit(itemId);
    if (weeklyBuyLimit > 0) {
        uint32 weekNum = timezoneTimestamp % 604800;
        uint32 buyTimes = EventTimes.get(userId, eventId, 1, weekNum);
        require(buyTimes + itemNum <= weeklyBuyLimit, "reach weekly purchase limit");
    }

    // check montly buy limit
    // notice that month is 30 days, not exactly 1 month
    uint32 monthlyBuyLimit = Shop.getItemMonthlyBuyLimit(itemId);
    if (monthlyBuyLimit > 0) {
        uint32 monthNum = timezoneTimestamp % 2592000;
        uint32 buyTimes = EventTimes.get(userId, eventId, 2, monthNum);
        require(buyTimes + itemNum <= monthlyBuyLimit, "reach monthly purchase limit");
    }

    // check forever buy limit
    uint32 foreverBuyLimit = Shop.getItemForeverBuyLimit(itemId);
    if (foreverBuyLimit > 0) {
        uint32 buyTimes = EventTimes.get(userId, eventId, 4, 0);
        require(buyTimes + itemNum <= foreverBuyLimit, "reach forever purchase limit");
    }

    // check user hold limit
    uint32 maxHoldLimit = ItemConfig.getMaxHoldTime(itemId);
    // if maxHoldLimit is 0, means no limit
    if (maxHoldLimit > 0) {
        uint32 userHoldNum = UserItems.getItemNum(userId);
        require(userHoldNum + itemNum <= maxHoldLimit, "reach max hold limit");
    }

  }

  


  
}
