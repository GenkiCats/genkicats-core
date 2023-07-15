// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
// import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { IUniqueEntitySystem } from "@latticexyz/world/src/interfaces/IUniqueEntitySystem.sol";
// import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";
import { Cat, Address2User, Address2UserTableId, UserMainAddress} from "../codegen/Tables.sol";
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { UsedKeysIndex } from "@latticexyz/world/src/modules/keysintable/tables/UsedKeysIndex.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

contract UserSystem is System {

  function userExist(address userAddress) public view returns(bool) {
   address store = StoreSwitch.inferStoreAddress();
   bytes32 keysHash = keccak256(abi.encode(userAddress));

   bool isBind = UsedKeysIndex.getHas(IStore(store), Address2UserTableId, keysHash);
   return isBind;
}

  function register(address userAddress) public {
    bool isBind = userExist(userAddress);
    require(isBind == false, "user already binded");

    address store = StoreSwitch.inferStoreAddress();
    bytes32 newUserId = IUniqueEntitySystem(store).uniqueEntity_system_getUniqueEntity();
    // bytes32 newUserId = getUniqueEntity();
    
    // map user address to new user id
    Address2User.set(_msgSender(), newUserId);
    // set user main address to init address
    UserMainAddress.set(newUserId, _msgSender());
  }

  /***
    * @dev change main address
    * @notice Any address be attached to userId can change its corresponding main address
    * @param newMainAddress new main address
    */  
  function changeMainAddress(address newMainAddress) public {
    bytes32 userId = Address2User.get(_msgSender());
    require(userId != bytes32(0), "user not binded");
    UserMainAddress.set(userId, newMainAddress);
  }

  function unBindUser() public {
    bytes32 userId = Address2User.get(_msgSender());
    require(userId != bytes32(0), "user not binded");
    address mainAddress = UserMainAddress.get(userId);
    require(mainAddress != _msgSender(), "can not unbind main address");
    Address2User.deleteRecord(_msgSender());
  }

  function attachToUser(address addressToAttach) public {
    bytes32 userId = Address2User.get(_msgSender());
    require(userId != bytes32(0), "user not binded");
    Address2User.set(addressToAttach, userId);
  }


  
}
