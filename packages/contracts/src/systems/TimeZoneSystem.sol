// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserStatus } from "../codegen/Tables.sol";

contract TimeZoneSystem is System {
  function getTimeZoneTimestamp(bytes32 userId) public view returns (uint) {
    uint32 timezoneOffset = UserStatus.getTimeZoneOffset(userId);
    bool timeZoneSign = UserStatus.getTimeZoneSign(userId);
    uint timezoneTimestamp;
    if (timeZoneSign == true) {
      timezoneTimestamp = block.timestamp + timezoneOffset;
    } else {
      timezoneTimestamp = block.timestamp - timezoneOffset;
    }
    return timezoneTimestamp;
  }

  function getTimeUnitNum(uint timezoneTimestamp, uint timeGapSeconds) public pure returns (uint) {
    uint timeUnitNum = timezoneTimestamp / timeGapSeconds;
    return timeUnitNum;
  }

  function getDayNum(uint timezoneTimestamp) public pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 86400));
  }

  function getWeekNum(uint timezoneTimestamp) public pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 604800));
  }

  function getMonthNum(uint timezoneTimestamp) public pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 2592000));
  }

  function getYearNum(uint timezoneTimestamp) public pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 31536000));
  }

  function signedNumber(uint32 number, bool sign) public pure returns (int64) {
    if (sign == true) {
      return int64(uint64(number));
    } else {
      return -int64(uint64(number));
    }
  }

  function changeTimeZone(bytes32 userId, uint32 newTimezoneOffset, bool newTimeZoneSign) public {
    uint32 currentTimeZoneOffset = UserStatus.getTimeZoneOffset(userId);
    bool currentTimeZoneSign = UserStatus.getTimeZoneSign(userId);
    int64 currentTimeZoneOffsetWithSign = signedNumber(currentTimeZoneOffset, currentTimeZoneSign);
    int64 newTimeZoneOffsetWithSign = signedNumber(newTimezoneOffset, newTimeZoneSign);
    if (currentTimeZoneOffsetWithSign >= newTimeZoneOffsetWithSign) {
      // No benefits for user if we change timezone to a smaller one
      UserStatus.setTimeZoneOffset(userId, newTimezoneOffset);
      UserStatus.setTimeZoneSign(userId, newTimeZoneSign);
    } else {
      // Plus 1 day for user if we change timezone to a bigger one to avoid user abuse
      newTimeZoneOffsetWithSign = newTimeZoneOffsetWithSign + 86400;
      if (newTimeZoneOffsetWithSign > 0) {
        newTimeZoneSign = true;
        require(newTimeZoneOffsetWithSign < 86400 * 99, "increase time zone too many times");
        newTimezoneOffset = uint32(uint64(newTimeZoneOffsetWithSign));
      } else {
        newTimeZoneSign = false;
        newTimezoneOffset = uint32(uint64(-newTimeZoneOffsetWithSign));
      }
      UserStatus.setTimeZoneOffset(userId, newTimezoneOffset);
      UserStatus.setTimeZoneSign(userId, newTimeZoneSign);
    }
  }
}
