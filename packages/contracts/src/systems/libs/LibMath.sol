// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library LibMath {
  function signedNumber(uint32 number, bool sign) internal pure returns (int64) {
    if (sign == true) {
      return int64(uint64(number));
    } else {
      return -int64(uint64(number));
    }
  }
}
