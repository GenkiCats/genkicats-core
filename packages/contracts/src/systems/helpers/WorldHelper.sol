// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { IWorld } from "../../codegen/world/IWorld.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

function getWorld() view returns (IWorld) {
  address store = StoreSwitch.inferStoreAddress();
  return IWorld(store);
}
