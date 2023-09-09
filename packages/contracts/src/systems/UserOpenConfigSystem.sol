// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { UserStatus } from "../codegen/Tables.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { LibTime } from "./libs/LibTime.sol";
import { LibMath } from "./libs/LibMath.sol";

contract UserOpenConfigSystem is System {
  function changeTimeZone(uint32 newTimezoneOffset, bool newTimeZoneSign) public {
    bytes32 userId = getUserId(_msgSender());
    uint32 currentTimeZoneOffset = UserStatus.getTimeZoneOffset(userId);
    bool currentTimeZoneSign = UserStatus.getTimeZoneSign(userId);
    int64 currentTimeZoneOffsetWithSign = LibMath.signedNumber(currentTimeZoneOffset, currentTimeZoneSign);
    int64 newTimeZoneOffsetWithSign = LibMath.signedNumber(newTimezoneOffset, newTimeZoneSign);
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
