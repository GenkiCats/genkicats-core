// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { Address2User } from "../../src/codegen/Tables.sol";
import { IWorld } from "../../src/codegen/world/IWorld.sol";

function getUserId(IWorld world, address userAddress) view returns (bytes32) {
  bytes32 userId = Address2User.get(world, userAddress);
  if (userId == bytes32(0)) {
    revert("address not regitered");
  }
  return userId;
}
