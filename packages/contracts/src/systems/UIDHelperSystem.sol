// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { GlobalIDCount } from "../codegen/Tables.sol";

// subsystem for generating unique id
contract UIDHelperSystem is System {
  function genUID() public returns (bytes32) {
    uint256 id = GlobalIDCount.get() + 1;
    GlobalIDCount.set(id);
    return bytes32(id);
  }
}
