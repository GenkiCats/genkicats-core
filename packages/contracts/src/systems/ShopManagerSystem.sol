// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { Shop} from "../codegen/Tables.sol";
import { IWorld } from "../codegen/world/IWorld.sol";

contract ShopManagerSystem is System {

  function listItem(uint itemId, uint coinPrice, uint diamondPrice) public {
    if (coinPrice != 0) {
      Shop.setItemCoinPrice(itemId, coinPrice);
    }
    if (diamondPrice != 0) {
      Shop.setItemDiamondPrice(itemId, diamondPrice);
    }
  }

}
