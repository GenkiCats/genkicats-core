// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

import { EventTimes } from "../codegen/Tables.sol";

contract PeriodEventsSystem is System {
  function finishEvents(bytes32 userId, bytes32 eventId, uint32 timeUnit, uint32 times, uint32 maxTimes) public {
    IWorld world = getWorld();
    uint timeZoneTimestamp = world.getTimeZoneTimestamp(userId);
    uint32 timeUnitNum;
    if (timeUnit == 0) {
      timeUnitNum = world.getDayNum(timeZoneTimestamp);
    } else if (timeUnit == 1) {
      timeUnitNum = world.getWeekNum(timeZoneTimestamp);
    } else if (timeUnit == 2) {
      timeUnitNum = world.getMonthNum(timeZoneTimestamp);
    } else if (timeUnit == 3) {
      timeUnitNum = world.getYearNum(timeZoneTimestamp);
    } else if (timeUnit == 4) {
      // forever event set timeUnitNum to 0 by design
      timeUnitNum = 0;
    } else {
      revert("invalid time unit");
    }

    uint32 curTimes = EventTimes.get(userId, eventId, timeUnit, timeUnitNum);
    // if maxTimes is 0, it means no limit
    uint32 newTimes = curTimes + times;
    if (maxTimes > 0) {
      require(newTimes <= maxTimes, "exceed max times");
    }
    EventTimes.set(userId, eventId, timeUnit, timeUnitNum, newTimes);
  }

  function finishDailyEvents(bytes32 userId, bytes32 eventId, uint32 times, uint32 maxTimes) public {
    finishEvents(userId, eventId, 0, times, maxTimes);
  }

  function finishWeeklyEvents(bytes32 userId, bytes32 eventId, uint32 times, uint32 maxTimes) public {
    finishEvents(userId, eventId, 1, times, maxTimes);
  }

  function finishMonthlyEvents(bytes32 userId, bytes32 eventId, uint32 times, uint32 maxTimes) public {
    finishEvents(userId, eventId, 2, times, maxTimes);
  }

  function finishYearlyEvents(bytes32 userId, bytes32 eventId, uint32 times, uint32 maxTimes) public {
    finishEvents(userId, eventId, 3, times, maxTimes);
  }

  function finishForeverEvents(bytes32 userId, bytes32 eventId, uint32 times, uint32 maxTimes) public {
    finishEvents(userId, eventId, 4, times, maxTimes);
  }
}
