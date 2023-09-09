// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { Cats, CatConfig, UserCats, UserCatList, CatLevelConfig, AutoFeederStatus } from "../../codegen/Tables.sol";
import { HobbyLog } from "../../codegen/Tables.sol";

library LibPet {
  function checkPetOwner(bytes32 petId, bytes32 userId) internal {
    bytes32 ownerId = Cats.getOwnerId(petId);
    //TODO: allow your friends to touch your cat
    require(userId == ownerId, "You are not the owner of this cat");
  }

  function checkPetStatus(bytes32 petId, bytes32 userId) internal {
    require(UserCats.getStatus(userId, petId) == 1, "The cat is not here");
  }

  function afterAddCat(bytes32 catId) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    totalHungerLimit += hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);

    for (uint256 i = 0; i < catIds.length; i++) {
      uint32 catLevel = Cats.getLevel(catIds[i]);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      AutoFeederStatus.setFeedRatio(catIds[i], rate);
    }
  }

  function beforeRemoveCat(bytes32 catId) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    totalHungerLimit -= hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);
    // clean the current auto feed rate
    AutoFeederStatus.setFeedRatio(catId, 0);
    // clean the last auto feed time
    AutoFeederStatus.setLastFeedTime(catId, 0);

    for (uint256 i = 0; i < catIds.length; i++) {
      bytes32 curCatId = catIds[i];
      // not update the cat which is going to be removed
      if (curCatId == catId) {
        continue;
      }
      uint32 catLevel = Cats.getLevel(curCatId);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      AutoFeederStatus.setFeedRatio(curCatId, rate);
    }

    /**
     * Abort active hobby
     */
    uint8 status = HobbyLog.getStatus(catId);
    if (status != 3) {
      HobbyLog.setStatus(catId, 4);
    }
  }

  function afterCatHungerLimitUpdate(bytes32 catId, uint32 oldHungerLimit) internal {
    bytes32 userId = Cats.getOwnerId(catId);
    uint32 totalHungerLimit = UserCatList.getTotalHungerLimit(userId);
    bytes32[] memory catIds = UserCatList.getCatIds(userId);
    uint32 catLevel = Cats.getLevel(catId);
    uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
    require(oldHungerLimit <= totalHungerLimit, "LibPet: oldHungerLimit must >= totalHungerLimit");
    totalHungerLimit = totalHungerLimit - oldHungerLimit;
    totalHungerLimit = totalHungerLimit + hungerLimit;
    UserCatList.setTotalHungerLimit(userId, totalHungerLimit);

    for (uint256 i = 0; i < catIds.length; i++) {
      uint32 catLevel = Cats.getLevel(catIds[i]);
      uint32 hungerLimit = CatLevelConfig.getHungerLimit(catLevel);
      uint32 rate = (hungerLimit * 10000) / totalHungerLimit;
      AutoFeederStatus.setFeedRatio(catIds[i], rate);
    }
  }

  function lostForever(bytes32 catId) internal {
    //TODO: cancel the cat's active activities
    // TODO: clear the current cat buffs
    // TODO: clear the cat's friendship
    bytes32 userId = Cats.getOwnerId(catId);
    UserCats.setStatus(userId, catId, 4);
    Cats.setFun(catId, 0);
    Cats.setHunger(catId, 0);
    UserCats.setFriendshipExp(userId, catId, 0);
    UserCats.setFriendshipLevel(userId, catId, 0);
  }

  function lostTemp(bytes32 catId) internal {
    //TODO: cancel the cat's active activities
    // TODO: clear the current cat buffs
    // TODO: reduce the cat's friendship
    bytes32 userId = Cats.getOwnerId(catId);
    UserCats.setStatus(userId, catId, 3);
    Cats.setFun(catId, 0);
    Cats.setHunger(catId, 0);
    UserCats.setFriendshipExp(userId, catId, 0);
    uint32 currentFriendshipLevel = UserCats.getFriendshipLevel(userId, catId);
    if (currentFriendshipLevel == 0) {
      return;
    } else {
      UserCats.setFriendshipLevel(userId, catId, currentFriendshipLevel - 1);
    }
  }

  function lost(bytes32 catId, uint32 friendshipLevel) internal {
    // deal jobs before remove the cat
    beforeRemoveCat(catId);
    // check if the cat will be lost forever
    uint32 foreverFriendshipLevel = CatConfig.getForeverFriendshipLevel();
    if (friendshipLevel < foreverFriendshipLevel) {
      lostForever(catId);
      return;
    } else {
      lostTemp(catId);
      return;
    }
  }
}
