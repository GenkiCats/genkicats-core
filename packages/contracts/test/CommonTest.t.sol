// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import { MudV2Test } from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { getUserId } from "./utils/UserTestHelper.sol";
import { Cats, UserStatus, Address2User, ItemConfig, UserItems, FoodConfig, UserCatList } from "../src/codegen/Tables.sol";
import { TestUser } from "./utils/TestUser.sol";

contract CommonTest is MudV2Test {
  IWorld public world;
  address public user1;
  bytes32 public userId1;

  address public admin;

  bytes32 public foodId1 = bytes32(uint256(1000101));
  bytes32 public taskId1 = bytes32(uint256(1001));

  function setUp() public override {
    super.setUp();
    world = IWorld(worldAddress);

    admin = address(new TestUser());
    vm.prank(admin);

    user1 = address(new TestUser());
    vm.startPrank(user1);
    world.registerUser();
    userId1 = getUserId(world, user1);
    vm.stopPrank();

    /**
     * Set up food
     *
     */
    // set food
    world.setFood(foodId1, 50, 5000, 0, 4, "Fish Can", "");

    // list food
    world.listBasicItem(foodId1, 10, 1);

    /**
     * Set up tasks
     */
    // Novice tasks
    bytes32[] memory rewardItemIds = new bytes32[](1);
    rewardItemIds[0] = foodId1;
    uint32[] memory rewardItemQuantities = new uint32[](1);
    rewardItemQuantities[0] = 2;
    world.setTask(
      taskId1,
      0,
      0,
      80,
      50,
      10,
      false,
      new bytes32[](1),
      new uint32[](1),
      rewardItemIds,
      rewardItemQuantities,
      "BeginnerTask",
      ""
    );
  }

  function testFinishTask() public {
    bytes32 userId = Address2User.get(world, user1);

    bytes32 itemId = bytes32(foodId1);

    vm.startPrank(user1);
    world.finishTask(taskId1);
    vm.stopPrank();

    assertEq(UserItems.getItemNum(world, userId, itemId), 2);
    vm.startPrank(user1);
    world.finishTask(taskId1);
    vm.stopPrank();

    assertEq(UserItems.getItemNum(world, userId, itemId), 4);
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

    bytes32 catId = UserCatList.getItemCatIds(world, userId1, 0);

    world.finishTask(taskId1);

    uint32 hungerBefore = Cats.getHunger(world, catId);
    world.feed(catId, foodId1, 1);
    uint32 hungerAfter = Cats.getHunger(world, catId);
    uint32 foodHunger = FoodConfig.getHunger(world, foodId1);
    console.log(foodHunger);
    assertEq(hungerBefore - hungerAfter, foodHunger);

    vm.stopPrank();
  }

  function testBuyItem() public {
    vm.startPrank(user1);

    world.finishTask(taskId1);
    uint32 itemNumBefore = UserItems.getItemNum(world, userId1, foodId1);
    world.buyItem(foodId1, 1, 0);
    uint32 itemNumAfter = UserItems.getItemNum(world, userId1, foodId1);
    assertEq(itemNumAfter - itemNumBefore, 1);
    vm.stopPrank();
  }
}
