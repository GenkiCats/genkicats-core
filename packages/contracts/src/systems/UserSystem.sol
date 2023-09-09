// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Address2User, UserMainAddress } from "../codegen/Tables.sol";
import { getWorld } from "./helpers/WorldHelper.sol";

contract UserSystem is System {
  function getUserId(address userAddress) public view returns (bytes32) {
    bytes32 userId = Address2User.get(userAddress);
    if (userId == bytes32(0)) {
      return bytes32(0);
    }
    return userId;
  }

  function registerUser() public {
    require(getUserId(_msgSender()) == bytes32(0), "address already binded");
    bytes32 newUserId = getWorld().genUID();
    Address2User.set(_msgSender(), newUserId);
    UserMainAddress.set(newUserId, _msgSender());
  }

  /***
   * @dev change main address
   * @notice Any address be attached to userId can change its corresponding main address
   * @param newMainAddress new main address
   */
  function changeMainAddress(address newMainAddress) public {
    bytes32 userId = getUserId(_msgSender());
    require(userId != bytes32(0), "address has not registered");
    require(getUserId(newMainAddress) == bytes32(0), "new address has been registered");
    UserMainAddress.set(userId, newMainAddress);
  }

  function unBindUser() public {
    bytes32 userId = getUserId(_msgSender());
    require(userId != bytes32(0), "address has not registered");
    address mainAddress = UserMainAddress.get(userId);
    require(mainAddress != _msgSender(), "can not unbind main address");
    Address2User.deleteRecord(_msgSender());
  }

  function attachToUser(address addressToAttach) public {
    bytes32 userId = getUserId(_msgSender());
    require(userId != bytes32(0), "address has not registered");
    require(getUserId(addressToAttach) == bytes32(0), "new address has been registered");
    Address2User.set(addressToAttach, userId);
  }
}
