// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { BuffConfig } from "../../codegen/Tables.sol";

library LibBuff {
  uint32 public constant DROP_RATE_MUL_BUFF_TYPE = 1001;
  uint32 public constant COIN_RATE_MUL_BUFF_TYPE = 1002;

  function isBuffValid(bytes32 buffId, uint256 startTime) internal view returns (bool) {
    if (buffId == bytes32(0)) {
      return false;
    }
    uint256 duration = BuffConfig.getDuration(buffId);
    uint256 endTime = startTime + duration;
    if (endTime > block.timestamp) {
      return true;
    } else {
      return false;
    }
  }
}
