// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { GlobalAddressConfig, GlobalRandomSourceConfig, PlayerInitConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract AdminConfigSystem is System {
  function setupTokenAddress(address tokenAddress) public {
    GlobalAddressConfig.set(keccak256("main_token"), tokenAddress);
  }

  function setupRandomSource(address randomSource) public {
    GlobalRandomSourceConfig.set(randomSource);
  }

  function setupPlayerInitConfig(uint256 initCoins) public {
    PlayerInitConfig.setInitCoins(initCoins);
  }

  function setupPlayerInitItem(bytes32[] memory itemIds) public {
    PlayerInitConfig.setInitItems(itemIds);
  }
}
