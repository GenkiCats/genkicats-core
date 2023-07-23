// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { Cats, UserStatus, Address2User, ItemConfig, UserItems, FoodConfig, UserCatList } from "../src/codegen/Tables.sol";
import { TestUser } from "./utils/TestUser.sol";

contract CommonTest is MudV2Test {
  IWorld public world;
  address public user1;
  address public admin;

  uint256 public foodID1 = 1000101;

  function setUp() public override {
    super.setUp();
    world = IWorld(worldAddress);

    admin = address(new TestUser());
    vm.prank(admin);

    user1 = address(new TestUser());
    vm.startPrank(user1);
    world.registerUser();
    vm.stopPrank();

    /**
     * Set up food
     *
     */
    // set food
    world.setFood(foodID1, 50, 5000, 0, "Fish Can", "");

    /**
     * Set up tasks
     */
    // Novice tasks
    uint[] memory rewardItemIds = new uint[](1);
    rewardItemIds[0] = foodID1;
    uint32[] memory rewardItemQuantities = new uint32[](1);
    rewardItemQuantities[0] = 2;
    world.setTask(
      1001,
      0,
      0,
      80,
      50,
      10,
      false,
      new uint256[](1),
      new uint32[](1),
      rewardItemIds,
      rewardItemQuantities,
      "BeginnerTask"
    );
  }

  function testFinishTask() public {
    bytes32 userId = Address2User.get(world, user1);

    vm.startPrank(user1);
    world.finishTask(1001);
    vm.stopPrank();

    assertEq(UserItems.getItemNum(world, userId, 1000101), 2);
    vm.startPrank(user1);
    world.finishTask(1001);
    vm.stopPrank();

    assertEq(UserItems.getItemNum(world, userId, 1000101), 4);
  }

  function testChores() public {
    bytes32 userId1 = Address2User.get(world, user1);
    console.log("userId1", uint256(userId1));
    uint256 coinBefore = UserStatus.getCoinBalance(world, userId1);
    console.log("coinBefore", coinBefore);
    vm.startPrank(user1);
    world.chores();
    vm.stopPrank();
    uint256 coinAfter = UserStatus.getCoinBalance(world, userId1);
    console.log("coinAfter", coinAfter);
  }

  function testCannotChoresTooMuch() public {
    vm.startPrank(user1);
    world.chores();
    world.chores();
    world.chores();
    world.chores();
    world.chores();

    vm.expectRevert("exceed max times");
    world.chores();

    // another day is OK
    vm.warp(1 days);
    world.chores();

    vm.stopPrank();
  }

  function testFeed() public {
    vm.startPrank(user1);
    world.adoptInitCat();

    bytes32 userId = Address2User.get(world, user1);
    bytes32 catId = UserCatList.getItem(world, userId, 0);

    world.finishTask(1001);

    uint32 hungerBefore = Cats.getHunger(world, catId);
    world.feed(catId, foodID1, 1);
    uint32 hungerAfter = Cats.getHunger(world, catId);
    uint32 foodHunger = FoodConfig.getHunger(world, foodID1);
    console.log(foodHunger);
    assertEq(hungerBefore - hungerAfter, foodHunger);

    vm.stopPrank();
  }

  // TODO: testBuyItem
  function testBuyItem() public {}
}
