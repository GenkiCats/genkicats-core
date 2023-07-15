// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import { getKeysWithValue } from "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { Cat } from "../src/codegen/Tables.sol";
import {TestUser} from "./TestUser.sol";

contract CatTest is MudV2Test {
  IWorld public world;
  address public user1;
  address public admin;

  function setUp() public override {
    super.setUp();
    world = IWorld(worldAddress);

    admin = address(new TestUser());
    vm.prank(admin);
    world.listItem(100010, 30, 0);

    user1 = address(new TestUser());
    vm.prank(user1);
    // world.register(user1, world);
    world.create();
    world.register(user1);

  }

  function testWorldExists() public {
    uint256 codeSize;
    address addr = worldAddress;
    assembly {
      codeSize := extcodesize(addr)
    }
    assertTrue(codeSize > 0);
  }

  function testFeed() public {
    world.create();
    world.feed();
    uint32 hunger = Cat.getHunger(world, 0);
    assertEq(hunger, 10, "hunger should be 10");
    string memory name = Cat.getName(world, 0);
    assertEq(name, "hanhan", "name should be hanhan");
  }
}
