// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { GlobalAddressConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract AdminSystem is System {
  function setTokenAddress(address tokenAddress) public {
    GlobalAddressConfig.set(keccak256("main_token"), tokenAddress);
  }
}
