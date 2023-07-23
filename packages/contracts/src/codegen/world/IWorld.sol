// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";

import { IAdminSystem } from "./IAdminSystem.sol";
import { ICatConfigSystem } from "./ICatConfigSystem.sol";
import { ICatSystem } from "./ICatSystem.sol";
import { IFoodConfigSystem } from "./IFoodConfigSystem.sol";
import { ILevelConfigSystem } from "./ILevelConfigSystem.sol";
import { IPeriodEventsSystem } from "./IPeriodEventsSystem.sol";
import { IQuantityHelperSystem } from "./IQuantityHelperSystem.sol";
import { IShopConfigSystem } from "./IShopConfigSystem.sol";
import { IShopSystem } from "./IShopSystem.sol";
import { ITaskConfigSystem } from "./ITaskConfigSystem.sol";
import { ITaskSystem } from "./ITaskSystem.sol";
import { ITimeZoneSystem } from "./ITimeZoneSystem.sol";
import { IUserSystem } from "./IUserSystem.sol";

/**
 * The IWorld interface includes all systems dynamically added to the World
 * during the deploy process.
 */
interface IWorld is
  IBaseWorld,
  IAdminSystem,
  ICatConfigSystem,
  ICatSystem,
  IFoodConfigSystem,
  ILevelConfigSystem,
  IPeriodEventsSystem,
  IQuantityHelperSystem,
  IShopConfigSystem,
  IShopSystem,
  ITaskConfigSystem,
  ITaskSystem,
  ITimeZoneSystem,
  IUserSystem
{

}
