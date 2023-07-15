// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Cat, UserItems, Address2User } from "../codegen/Tables.sol";

contract CatSystem is System {
  function create() public {
   bytes32 userId = Address2User.get(_msgSender());
   Cat.setName(0, "hanhan");
  }

  function feed() public returns (uint32) {
    uint32 hunger = Cat.getHunger(0);
    hunger = hunger + 10;
    Cat.setHunger(0, hunger);
    return hunger;
  }
}
