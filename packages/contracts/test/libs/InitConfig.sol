import { Cats, UserStatus, Address2User, ItemConfig, UserItems, FoodConfig, UserCatList, CatBornStatusConfig } from "../../src/codegen/Tables.sol";
import { RandomGenerator } from "../../src/systems/helpers/RandomGenerator.sol";
import { RandomSource } from "../../src/systems/helpers/RandomSource.sol";
import { IWorld } from "../../src/codegen/world/IWorld.sol";
import { LibConstants } from "../../src/systems/libs/LibConstants.sol";

import "forge-std/console.sol";

library InitConfig {
  function setupRandomSource(IWorld world) internal {
    RandomSource randomSource = new RandomSource(256);
    RandomGenerator randomGenerator = new RandomGenerator(address(randomSource));
    world.setupRandomSource(address(randomGenerator));
  }

  function setupCatBornStatusConfig(IWorld world) internal {
    // 500000, 1000000, 1000000
    // initHunger, initFun, initClean
    world.setupCatBornStatusConfig(400000, 800000, 500000);
  }

  function setupPlayerInitConfig(IWorld world) internal {
    world.setupPlayerInitConfig(100);
  }

  function setupCatConfig(IWorld world) internal {
    // hungerConsumeRate, funConsumeRate, baseDropRate, baseHungerCoinRate, starvingStartTime, foreverFriendshipLevel, funLimit, cleanLimit
    world.setupCatConfig(4, 4, 2500, 20000, 86400, 5, 1000000, 1000000);
    // friendshipLevel, expLimit, starvingTimeLimit
    world.setCatFriendshipLevelConfig(1, 1000000, 86400);
  }

  function setupCatLevelConfig(IWorld world) internal {
    uint32[30] memory rawCatLevels = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      uint32(30)
    ];
    uint32[] memory catLevels = new uint32[](rawCatLevels.length);
    for (uint256 i = 0; i < rawCatLevels.length; i++) {
      catLevels[i] = uint32(rawCatLevels[i]);
    }
    uint32[30] memory rawHungerLimits = [
      uint32(500000),
      600000,
      700000,
      800000,
      900000,
      1000000,
      1100000,
      1200000,
      1300000,
      1500000,
      1600000,
      1700000,
      1800000,
      1900000,
      2000000,
      2200000,
      2400000,
      2600000,
      2800000,
      3000000,
      3200000,
      3400000,
      3600000,
      3800000,
      4000000,
      4200000,
      4400000,
      4600000,
      4800000,
      5000000
    ];
    uint32[] memory hungerLimits = new uint32[](rawHungerLimits.length);
    for (uint256 i = 0; i < rawHungerLimits.length; i++) {
      hungerLimits[i] = uint32(rawHungerLimits[i]);
    }
    uint32[30] memory rawExpLimits = [
      uint32(500000),
      600000,
      700000,
      800000,
      900000,
      1000000,
      2100000,
      2200000,
      2600000,
      3000000,
      3200000,
      3400000,
      3600000,
      3800000,
      4000000,
      4400000,
      4800000,
      5200000,
      5600000,
      6000000,
      6400000,
      6800000,
      7200000,
      7600000,
      8000000,
      8400000,
      8800000,
      9200000,
      9600000,
      0
    ];
    uint32[] memory expLimits = new uint32[](rawExpLimits.length);
    for (uint256 i = 0; i < rawExpLimits.length; i++) {
      expLimits[i] = uint32(rawExpLimits[i]);
    }

    world.setupCatLevelConfig(catLevels, hungerLimits, expLimits);
  }

  function setupHobbyBasicConfig(IWorld world) public {
    // hungerCatExpRate, hungerUserExpRate
    world.setupHobbyBasicConfig(40000, 50000);

    uint8[] memory tiers = new uint8[](30);
    uint8[30] memory rawTiers = [
      1,
      1,
      1,
      1,
      1,
      1,
      2,
      2,
      2,
      2,
      2,
      3,
      3,
      3,
      3,
      3,
      3,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4
    ];
    for (uint256 i = 0; i < rawTiers.length; i++) {
      tiers[i] = uint8(rawTiers[i]);
    }
    world.setupHobbyLevelTierDefault(tiers);
    console.log("setupHobbyBasicConfig");
  }

  function setupHobbyTierChosenConfig(IWorld world) public {
    {
      uint8[] memory tier1ChoseRange = new uint8[](1);
      uint8[1] memory temptier1ChoseRange = [1];
      for (uint i = 0; i < 1; i++) {
        tier1ChoseRange[i] = temptier1ChoseRange[i];
      }
      world.setupHobbyTierChosenDefault(
        1,
        bytes32("hobby_tier_1_default"),
        0,
        tier1ChoseRange,
        new uint16[](0),
        new uint16[](0),
        new uint32[](0)
      );
    }
    {
      uint16[] memory tier2Indices = new uint16[](5);
      uint16[5] memory temptier2Indices = [uint16(0), 1, 1, 1, 1];
      for (uint i = 0; i < 5; i++) {
        tier2Indices[i] = temptier2Indices[i];
      }
      uint8[] memory tier2ChoseRange = new uint8[](2);
      uint8[2] memory temptier2ChoseRange = [1, 2];
      for (uint i = 0; i < 2; i++) {
        tier2ChoseRange[i] = temptier2ChoseRange[i];
      }
      world.setupHobbyTierChosenDefault(
        2,
        bytes32("hobby_tier_2_default"),
        1,
        tier2ChoseRange,
        tier2Indices,
        new uint16[](0),
        new uint32[](0)
      );
    }

    {
      uint16[] memory tier3Indices = new uint16[](4);
      uint16[4] memory temptier3Indices = [uint16(0), 1, 1, 1];
      for (uint i = 0; i < 4; i++) {
        tier3Indices[i] = temptier3Indices[i];
      }
      uint8[] memory tier3ChoseRange = new uint8[](2);
      uint8[2] memory temptier3ChoseRange = [2, 3];
      for (uint i = 0; i < 2; i++) {
        tier3ChoseRange[i] = temptier3ChoseRange[i];
      }

      world.setupHobbyTierChosenDefault(
        3,
        bytes32("hobby_tier_3_default"),
        1,
        tier3ChoseRange,
        tier3Indices,
        new uint16[](0),
        new uint32[](0)
      );
    }
    {
      uint16[] memory tier4Indices = new uint16[](20);
      uint16[20] memory temptier4Indices = [uint16(0), 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
      for (uint i = 0; i < 20; i++) {
        tier4Indices[i] = temptier4Indices[i];
      }

      uint8[] memory tier4ChoseRange = new uint8[](3);
      uint8[3] memory temptier4ChoseRange = [2, 3, 4];
      for (uint i = 0; i < 3; i++) {
        tier4ChoseRange[i] = temptier4ChoseRange[i];
      }

      world.setupHobbyTierChosenDefault(
        4,
        bytes32("hobby_tier_4_default"),
        1,
        tier4ChoseRange,
        tier4Indices,
        new uint16[](0),
        new uint32[](0)
      );
    }
    console.log("setupHobbyTierChosenConfig");
  }

  function setupHobbyTagChosenConfig(IWorld world) public {
    bytes32[] memory tagChosenRange = new bytes32[](1);
    bytes32[1] memory temptagChosenRange = [bytes32("hobby_id_default")];
    for (uint i = 0; i < 1; i++) {
      tagChosenRange[i] = temptagChosenRange[i];
    }
    world.setupHobbyTagChosenDefault(
      1,
      bytes32("hobby_tier_1_tag_chosen_default"),
      0,
      tagChosenRange,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyTagChosenDefault(
      2,
      bytes32("hobby_tier_2_tag_chosen_default"),
      0,
      tagChosenRange,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyTagChosenDefault(
      3,
      bytes32("hobby_tier_3_tag_chosen_default"),
      0,
      tagChosenRange,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyTagChosenDefault(
      4,
      bytes32("hobby_tier_4_tag_chosen_default"),
      0,
      tagChosenRange,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    console.log("setupHobbyTagChosenConfig");
  }

  function setupCustomHobby(IWorld world, string memory hobbyName) public {
    // hobbyName, uri, playerChosenTagNum, hungerConsumptionRate, extraRewardNum, hasExtraSteps, hobbyAttractiveItem, requiredItems, delayBlocks, strictRandom
    world.setupHobbyConfig(hobbyName, "", 0, 25, 0, false, bytes32(0), new bytes32[](0), 1, false);
    console.log("setupCustomHobby");
  }

  function setupHobbyTiers(IWorld world, bytes32 hobbyId) public {
    uint8[] memory tiers = new uint8[](4);
    uint8[4] memory temptiers = [uint8(1), 2, 3, 4];
    for (uint i = 0; i < 4; i++) {
      tiers[i] = temptiers[i];
    }
    uint256[] memory restTime = new uint256[](4);
    uint256[4] memory temprestTime = [uint256(600), 1200, 1800, 3600];
    for (uint i = 0; i < 4; i++) {
      restTime[i] = temprestTime[i];
    }
    uint256[] memory baseRestTime = new uint256[](4);
    uint256[4] memory tempbaseRestTime = [uint256(600), 1200, 1800, 3600];
    for (uint i = 0; i < 4; i++) {
      baseRestTime[i] = tempbaseRestTime[i];
    }
    // hobbyId, tiers, baseTimes, baseRestTimes
    world.setupHobbyTierTimes(hobbyId, tiers, restTime, baseRestTime);
    console.log("setupHobbyTiers");
  }

  function setupHobbyTags(IWorld world, bytes32 hobbyId) public {
    // set custome tag chosenRange
    bytes32[] memory tagChosenRange = new bytes32[](1);
    bytes32[1] memory temptagChosenRange = [bytes32("default")];
    for (uint i = 0; i < 1; i++) {
      tagChosenRange[i] = temptagChosenRange[i];
    }
    // hobbyId, tier, tagChosenRange
    world.setHobbyTagChosenRange(hobbyId, 1, tagChosenRange);
    world.setHobbyTagChosenRange(hobbyId, 2, tagChosenRange);
    world.setHobbyTagChosenRange(hobbyId, 3, tagChosenRange);
    world.setHobbyTagChosenRange(hobbyId, 4, tagChosenRange);
    console.log("setupHobbyTags");
  }

  function setupHobbyItems(IWorld world, bytes32 hobbyId) public {
    bytes32[] memory tagChosenRange = new bytes32[](1);
    bytes32[1] memory temptagChosenRange = [bytes32("default")];
    for (uint i = 0; i < 1; i++) {
      tagChosenRange[i] = temptagChosenRange[i];
    }

    bytes32 defaultTagId = tagChosenRange[0];
    console.log("defaultTagId: %s", uint256(defaultTagId));
    bytes32 tier1SampleId = bytes32("hobby_tier_1_sample_id");
    bytes32 tier2SampleId = bytes32("hobby_tier_2_sample_id");
    bytes32 tier3SampleId = bytes32("hobby_tier_3_sample_id");
    bytes32 tier4SampleId = bytes32("hobby_tier_4_sample_id");

    bytes32[] memory defaultRewardItemIds = new bytes32[](4);
    defaultRewardItemIds[0] = keccak256(abi.encodePacked("photo: night star sky"));
    defaultRewardItemIds[1] = keccak256(abi.encodePacked("photo: reading"));
    defaultRewardItemIds[2] = keccak256(abi.encodePacked("photo: snowman"));
    defaultRewardItemIds[3] = keccak256(abi.encodePacked("photo: baking"));

    bytes32[] memory springFestivalRewardItemIds = new bytes32[](2);

    springFestivalRewardItemIds[0] = keccak256(abi.encodePacked("photo: Chinese Lion"));
    springFestivalRewardItemIds[1] = keccak256(abi.encodePacked("photo: Chinese Dragon"));

    bytes32[] memory christmaslRewardItemIds = new bytes32[](2);

    christmaslRewardItemIds[0] = keccak256(abi.encodePacked("photo: Christmas Tree"));
    christmaslRewardItemIds[1] = keccak256(abi.encodePacked("photo: Christmas Socks"));

    for (uint i = 0; i < defaultRewardItemIds.length; i++) {
      world.setItem(defaultRewardItemIds[i], "", "");
    }
    for (uint i = 0; i < springFestivalRewardItemIds.length; i++) {
      world.setItem(springFestivalRewardItemIds[i], "", "");
    }
    for (uint i = 0; i < christmaslRewardItemIds.length; i++) {
      world.setItem(christmaslRewardItemIds[i], "", "");
    }

    world.setupHobbyRewardItemChosenConfig(
      hobbyId,
      1,
      defaultTagId,
      tier1SampleId,
      0,
      defaultRewardItemIds,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyRewardItemChosenConfig(
      hobbyId,
      2,
      defaultTagId,
      tier2SampleId,
      0,
      defaultRewardItemIds,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyRewardItemChosenConfig(
      hobbyId,
      3,
      defaultTagId,
      tier3SampleId,
      0,
      defaultRewardItemIds,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );
    world.setupHobbyRewardItemChosenConfig(
      hobbyId,
      4,
      defaultTagId,
      tier4SampleId,
      0,
      defaultRewardItemIds,
      new uint16[](0),
      new uint16[](0),
      new uint32[](0)
    );

    // bytes32[] memory tagIds = new bytes32[](3);
    // bytes32 defaultTag = keccak256(abi.encodePacked("default"));
    // bytes32 springFestivalTag = keccak256(abi.encodePacked("Spring Festival"));
    // bytes32 christmasTag = keccak256(abi.encodePacked("Christmas"));
    // tagIds[0] = defaultTag;
    // tagIds[1] = springFestivalTag;
    // tagIds[2] = christmasTag;

    // world.setHobbyRewardItems(hobbyId, 1, defaultTag, defaultRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 1, springFestivalTag, springFestivalRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 1, christmasTag, christmaslRewardItemIds, 0);

    // world.setHobbyRewardItems(hobbyId, 2, defaultTag, defaultRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 2, springFestivalTag, springFestivalRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 2, christmasTag, christmaslRewardItemIds, 0);

    // world.setHobbyRewardItems(hobbyId, 3, defaultTag, defaultRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 3, springFestivalTag, springFestivalRewardItemIds, 0);
    // world.setHobbyRewardItems(hobbyId, 3, christmasTag, christmaslRewardItemIds, 0);
    console.log("setUpHobbyItemConfig");
  }

  function setUpHobby(IWorld world) public {
    string memory hobbyName = "travel";
    bytes32 hobbyId = bytes32(bytes(hobbyName));

    setupHobbyBasicConfig(world);
    setupHobbyTierChosenConfig(world);
    setupHobbyTagChosenConfig(world);
    setupCustomHobby(world, hobbyName);
    setupHobbyTiers(world, hobbyId);
    setupHobbyTags(world, hobbyId);
    setupHobbyItems(world, hobbyId);
  }
}
