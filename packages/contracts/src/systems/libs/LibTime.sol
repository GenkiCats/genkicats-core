// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { UserStatus } from "../../codegen/Tables.sol";

library LibTime {
  function getTimeZoneTimestamp(bytes32 userId) internal view returns (uint) {
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

  function getTimeUnitNum(uint timezoneTimestamp, uint timeGapSeconds) internal pure returns (uint) {
    uint timeUnitNum = timezoneTimestamp / timeGapSeconds;
    return timeUnitNum;
  }

  function getDayNum(uint timezoneTimestamp) internal pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 86400));
  }

  function getWeekNum(uint timezoneTimestamp) internal pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 604800));
  }

  function getMonthNum(uint timezoneTimestamp) internal pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 2592000));
  }

  function getYearNum(uint timezoneTimestamp) internal pure returns (uint32) {
    return uint32(getTimeUnitNum(timezoneTimestamp, 31536000));
  }
}
