// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IFoodConfigSystem {
  function setFood(
    uint itemId,
    uint32 hunger,
    uint32 travelDropRate,
    uint32 maxItemQuantity,
    string memory name,
    string memory uri
  ) external;
}