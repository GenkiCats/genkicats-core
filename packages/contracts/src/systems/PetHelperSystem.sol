import { System } from "@latticexyz/world/src/System.sol";
import { getUserId } from "./helpers/UserHelper.sol";
import { getWorld } from "./helpers/WorldHelper.sol";
import { IWorld } from "../codegen/world/IWorld.sol";
import { UserAdoptions, UserCats, UserCatList, CatBornStatusConfig } from "../codegen/Tables.sol";
import { Cats, CatAttributes } from "../codegen/Tables.sol";

import { getSimpleRandomInt, getSimpleRandomBool } from "./helpers/RandomHelper.sol";

//TODO: remove in production
import "forge-std/console.sol";

contract PetHelperSystem is System {
  string public constant INIT_HOBBY = "travel";

  function bornPet(bytes32 userId) internal returns (bytes32) {
    bytes32 catId = getWorld().genUID();
    UserCats.setObtainTime(userId, catId, block.timestamp);
    UserCats.setStatus(userId, catId, 1);
    UserCats.setFriendshipLevel(userId, catId, 1);
    UserCats.setFriendshipExp(userId, catId, 0);
    UserCatList.pushCatIds(userId, catId);

    Cats.setOwnerId(catId, userId);
    Cats.setExp(catId, 0);
    Cats.setLevel(catId, 1);
    Cats.setHunger(catId, CatBornStatusConfig.getHunger());
    Cats.setFun(catId, CatBornStatusConfig.getFun());
    Cats.setClean(catId, CatBornStatusConfig.getClean());
    Cats.setStarvingTime(catId, 0);
    Cats.setLastUpdateTime(catId, block.timestamp);

    CatAttributes.setBirthTime(catId, block.timestamp);

    return catId;
  }

  function adoptInitCat() public {
    console.log("adoptInitCat");
    bytes32 userId = getUserId(_msgSender());

    // adoption number check
    uint32 adoptionNum = UserAdoptions.get(userId);
    require(adoptionNum == 0, "You have already adopted the first cat");
    UserAdoptions.set(userId, 1);

    // born new pet
    bytes32 catId = bornPet(userId);
    UserCats.setObtainMethod(userId, catId, 0);

    /**
     * Attributes Generation
     *
     */
    bool sex = getSimpleRandomBool();
    // init cat is traveling cat by default
    bytes32 hobbyId = bytes32(bytes(INIT_HOBBY));
    uint256 personality = getSimpleRandomInt(1000000000);
    uint256 skin = getSimpleRandomInt(12);

    CatAttributes.setSex(catId, sex);
    CatAttributes.setHobbyId(catId, hobbyId);
    CatAttributes.setPersonality(catId, personality);
    CatAttributes.setSkin(catId, skin);
    // set init update time
    getWorld().liveUpdate(catId);
  }
}
