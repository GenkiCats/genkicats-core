// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { ItemConfig, MetaConfig, ItemBuffConfig } from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract ItemConfigSystem is System {
  function setupItems(bytes32[] memory itemIds, string[] memory names, string[] memory uris) public {
    for (uint i = 0; i < itemIds.length; i++) {
      setItem(itemIds[i], names[i], uris[i]);
    }
  }

  function setItem(bytes32 itemId, string memory name, string memory uri) public {
    address designer = ItemConfig.getDesigner(itemId);
    if (designer != address(0)) {
      require(designer == _msgSender(), "Only item designer can update info");
    }
    ItemConfig.setDesigner(itemId, _msgSender());
    MetaConfig.set(itemId, name, uri);
  }
}
