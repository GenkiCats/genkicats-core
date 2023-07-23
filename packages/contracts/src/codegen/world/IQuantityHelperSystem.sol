// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IQuantityHelperSystem {
  function addItem(bytes32 userId, uint256 itemId, uint32 quantity) external;

  function decItem(bytes32 userId, uint256 itemId, uint32 quantity) external;

  function addCoin(bytes32 userId, uint256 quantity) external;

  function decCoin(bytes32 userId, uint256 quantity) external;

  function addDiamond(bytes32 userId, uint256 quantity) external;

  function decDiamond(bytes32 userId, uint256 quantity) external;

  function addExp(bytes32 userId, uint32 quantity) external;
}