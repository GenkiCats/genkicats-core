// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Cats")));
bytes32 constant CatsTableId = _tableId;

struct CatsData {
  bytes32 ownerId;
  uint32 exp;
  uint32 level;
  uint32 hunger;
  uint32 fun;
  uint32 clean;
  uint256 starvingTime;
  uint256 lastUpdateTime;
}

library Cats {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](8);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.UINT32;
    _schema[2] = SchemaType.UINT32;
    _schema[3] = SchemaType.UINT32;
    _schema[4] = SchemaType.UINT32;
    _schema[5] = SchemaType.UINT32;
    _schema[6] = SchemaType.UINT256;
    _schema[7] = SchemaType.UINT256;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](8);
    _fieldNames[0] = "ownerId";
    _fieldNames[1] = "exp";
    _fieldNames[2] = "level";
    _fieldNames[3] = "hunger";
    _fieldNames[4] = "fun";
    _fieldNames[5] = "clean";
    _fieldNames[6] = "starvingTime";
    _fieldNames[7] = "lastUpdateTime";
    return ("Cats", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get ownerId */
  function getOwnerId(bytes32 cat_id) internal view returns (bytes32 ownerId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get ownerId (using the specified store) */
  function getOwnerId(IStore _store, bytes32 cat_id) internal view returns (bytes32 ownerId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set ownerId */
  function setOwnerId(bytes32 cat_id, bytes32 ownerId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((ownerId)));
  }

  /** Set ownerId (using the specified store) */
  function setOwnerId(IStore _store, bytes32 cat_id, bytes32 ownerId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((ownerId)));
  }

  /** Get exp */
  function getExp(bytes32 cat_id) internal view returns (uint32 exp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get exp (using the specified store) */
  function getExp(IStore _store, bytes32 cat_id) internal view returns (uint32 exp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set exp */
  function setExp(bytes32 cat_id, uint32 exp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((exp)));
  }

  /** Set exp (using the specified store) */
  function setExp(IStore _store, bytes32 cat_id, uint32 exp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((exp)));
  }

  /** Get level */
  function getLevel(bytes32 cat_id) internal view returns (uint32 level) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get level (using the specified store) */
  function getLevel(IStore _store, bytes32 cat_id) internal view returns (uint32 level) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set level */
  function setLevel(bytes32 cat_id, uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((level)));
  }

  /** Set level (using the specified store) */
  function setLevel(IStore _store, bytes32 cat_id, uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((level)));
  }

  /** Get hunger */
  function getHunger(bytes32 cat_id) internal view returns (uint32 hunger) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get hunger (using the specified store) */
  function getHunger(IStore _store, bytes32 cat_id) internal view returns (uint32 hunger) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set hunger */
  function setHunger(bytes32 cat_id, uint32 hunger) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((hunger)));
  }

  /** Set hunger (using the specified store) */
  function setHunger(IStore _store, bytes32 cat_id, uint32 hunger) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((hunger)));
  }

  /** Get fun */
  function getFun(bytes32 cat_id) internal view returns (uint32 fun) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get fun (using the specified store) */
  function getFun(IStore _store, bytes32 cat_id) internal view returns (uint32 fun) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set fun */
  function setFun(bytes32 cat_id, uint32 fun) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 4, abi.encodePacked((fun)));
  }

  /** Set fun (using the specified store) */
  function setFun(IStore _store, bytes32 cat_id, uint32 fun) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 4, abi.encodePacked((fun)));
  }

  /** Get clean */
  function getClean(bytes32 cat_id) internal view returns (uint32 clean) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get clean (using the specified store) */
  function getClean(IStore _store, bytes32 cat_id) internal view returns (uint32 clean) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set clean */
  function setClean(bytes32 cat_id, uint32 clean) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 5, abi.encodePacked((clean)));
  }

  /** Set clean (using the specified store) */
  function setClean(IStore _store, bytes32 cat_id, uint32 clean) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 5, abi.encodePacked((clean)));
  }

  /** Get starvingTime */
  function getStarvingTime(bytes32 cat_id) internal view returns (uint256 starvingTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 6);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get starvingTime (using the specified store) */
  function getStarvingTime(IStore _store, bytes32 cat_id) internal view returns (uint256 starvingTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 6);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set starvingTime */
  function setStarvingTime(bytes32 cat_id, uint256 starvingTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 6, abi.encodePacked((starvingTime)));
  }

  /** Set starvingTime (using the specified store) */
  function setStarvingTime(IStore _store, bytes32 cat_id, uint256 starvingTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 6, abi.encodePacked((starvingTime)));
  }

  /** Get lastUpdateTime */
  function getLastUpdateTime(bytes32 cat_id) internal view returns (uint256 lastUpdateTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 7);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get lastUpdateTime (using the specified store) */
  function getLastUpdateTime(IStore _store, bytes32 cat_id) internal view returns (uint256 lastUpdateTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 7);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set lastUpdateTime */
  function setLastUpdateTime(bytes32 cat_id, uint256 lastUpdateTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setField(_tableId, _keyTuple, 7, abi.encodePacked((lastUpdateTime)));
  }

  /** Set lastUpdateTime (using the specified store) */
  function setLastUpdateTime(IStore _store, bytes32 cat_id, uint256 lastUpdateTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setField(_tableId, _keyTuple, 7, abi.encodePacked((lastUpdateTime)));
  }

  /** Get the full data */
  function get(bytes32 cat_id) internal view returns (CatsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 cat_id) internal view returns (CatsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 cat_id,
    bytes32 ownerId,
    uint32 exp,
    uint32 level,
    uint32 hunger,
    uint32 fun,
    uint32 clean,
    uint256 starvingTime,
    uint256 lastUpdateTime
  ) internal {
    bytes memory _data = encode(ownerId, exp, level, hunger, fun, clean, starvingTime, lastUpdateTime);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 cat_id,
    bytes32 ownerId,
    uint32 exp,
    uint32 level,
    uint32 hunger,
    uint32 fun,
    uint32 clean,
    uint256 starvingTime,
    uint256 lastUpdateTime
  ) internal {
    bytes memory _data = encode(ownerId, exp, level, hunger, fun, clean, starvingTime, lastUpdateTime);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 cat_id, CatsData memory _table) internal {
    set(
      cat_id,
      _table.ownerId,
      _table.exp,
      _table.level,
      _table.hunger,
      _table.fun,
      _table.clean,
      _table.starvingTime,
      _table.lastUpdateTime
    );
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 cat_id, CatsData memory _table) internal {
    set(
      _store,
      cat_id,
      _table.ownerId,
      _table.exp,
      _table.level,
      _table.hunger,
      _table.fun,
      _table.clean,
      _table.starvingTime,
      _table.lastUpdateTime
    );
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (CatsData memory _table) {
    _table.ownerId = (Bytes.slice32(_blob, 0));

    _table.exp = (uint32(Bytes.slice4(_blob, 32)));

    _table.level = (uint32(Bytes.slice4(_blob, 36)));

    _table.hunger = (uint32(Bytes.slice4(_blob, 40)));

    _table.fun = (uint32(Bytes.slice4(_blob, 44)));

    _table.clean = (uint32(Bytes.slice4(_blob, 48)));

    _table.starvingTime = (uint256(Bytes.slice32(_blob, 52)));

    _table.lastUpdateTime = (uint256(Bytes.slice32(_blob, 84)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    bytes32 ownerId,
    uint32 exp,
    uint32 level,
    uint32 hunger,
    uint32 fun,
    uint32 clean,
    uint256 starvingTime,
    uint256 lastUpdateTime
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(ownerId, exp, level, hunger, fun, clean, starvingTime, lastUpdateTime);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 cat_id) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 cat_id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 cat_id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = cat_id;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
