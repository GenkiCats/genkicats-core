// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { Address2User } from "../../codegen/Tables.sol";

function getUserId(address userAddress) view returns (bytes32) {
  bytes32 userId = Address2User.get(userAddress);
  if (userId == bytes32(0)) {
    revert("address not regitered");
  }
  return userId;
}
