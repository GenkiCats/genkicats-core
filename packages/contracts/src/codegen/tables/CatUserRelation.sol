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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("CatUserRelation")));
bytes32 constant CatUserRelationTableId = _tableId;

struct CatUserRelationData {
  uint256 catId;
  uint32 friendship;
  uint32 obtainTime;
  uint32 lostTime;
  uint8 obtainMethod;
}

library CatUserRelation {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](5);
    _schema[0] = SchemaType.UINT256;
    _schema[1] = SchemaType.UINT32;
    _schema[2] = SchemaType.UINT32;
    _schema[3] = SchemaType.UINT32;
    _schema[4] = SchemaType.UINT8;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](5);
    _fieldNames[0] = "catId";
    _fieldNames[1] = "friendship";
    _fieldNames[2] = "obtainTime";
    _fieldNames[3] = "lostTime";
    _fieldNames[4] = "obtainMethod";
    return ("CatUserRelation", _fieldNames);
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

  /** Get catId */
  function getCatId(bytes32 userId) internal view returns (uint256 catId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get catId (using the specified store) */
  function getCatId(IStore _store, bytes32 userId) internal view returns (uint256 catId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set catId */
  function setCatId(bytes32 userId, uint256 catId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((catId)));
  }

  /** Set catId (using the specified store) */
  function setCatId(IStore _store, bytes32 userId, uint256 catId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((catId)));
  }

  /** Get friendship */
  function getFriendship(bytes32 userId) internal view returns (uint32 friendship) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get friendship (using the specified store) */
  function getFriendship(IStore _store, bytes32 userId) internal view returns (uint32 friendship) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set friendship */
  function setFriendship(bytes32 userId, uint32 friendship) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((friendship)));
  }

  /** Set friendship (using the specified store) */
  function setFriendship(IStore _store, bytes32 userId, uint32 friendship) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((friendship)));
  }

  /** Get obtainTime */
  function getObtainTime(bytes32 userId) internal view returns (uint32 obtainTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get obtainTime (using the specified store) */
  function getObtainTime(IStore _store, bytes32 userId) internal view returns (uint32 obtainTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set obtainTime */
  function setObtainTime(bytes32 userId, uint32 obtainTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((obtainTime)));
  }

  /** Set obtainTime (using the specified store) */
  function setObtainTime(IStore _store, bytes32 userId, uint32 obtainTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((obtainTime)));
  }

  /** Get lostTime */
  function getLostTime(bytes32 userId) internal view returns (uint32 lostTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get lostTime (using the specified store) */
  function getLostTime(IStore _store, bytes32 userId) internal view returns (uint32 lostTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set lostTime */
  function setLostTime(bytes32 userId, uint32 lostTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((lostTime)));
  }

  /** Set lostTime (using the specified store) */
  function setLostTime(IStore _store, bytes32 userId, uint32 lostTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((lostTime)));
  }

  /** Get obtainMethod */
  function getObtainMethod(bytes32 userId) internal view returns (uint8 obtainMethod) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Get obtainMethod (using the specified store) */
  function getObtainMethod(IStore _store, bytes32 userId) internal view returns (uint8 obtainMethod) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Set obtainMethod */
  function setObtainMethod(bytes32 userId, uint8 obtainMethod) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 4, abi.encodePacked((obtainMethod)));
  }

  /** Set obtainMethod (using the specified store) */
  function setObtainMethod(IStore _store, bytes32 userId, uint8 obtainMethod) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 4, abi.encodePacked((obtainMethod)));
  }

  /** Get the full data */
  function get(bytes32 userId) internal view returns (CatUserRelationData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 userId) internal view returns (CatUserRelationData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 userId,
    uint256 catId,
    uint32 friendship,
    uint32 obtainTime,
    uint32 lostTime,
    uint8 obtainMethod
  ) internal {
    bytes memory _data = encode(catId, friendship, obtainTime, lostTime, obtainMethod);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 userId,
    uint256 catId,
    uint32 friendship,
    uint32 obtainTime,
    uint32 lostTime,
    uint8 obtainMethod
  ) internal {
    bytes memory _data = encode(catId, friendship, obtainTime, lostTime, obtainMethod);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 userId, CatUserRelationData memory _table) internal {
    set(userId, _table.catId, _table.friendship, _table.obtainTime, _table.lostTime, _table.obtainMethod);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 userId, CatUserRelationData memory _table) internal {
    set(_store, userId, _table.catId, _table.friendship, _table.obtainTime, _table.lostTime, _table.obtainMethod);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (CatUserRelationData memory _table) {
    _table.catId = (uint256(Bytes.slice32(_blob, 0)));

    _table.friendship = (uint32(Bytes.slice4(_blob, 32)));

    _table.obtainTime = (uint32(Bytes.slice4(_blob, 36)));

    _table.lostTime = (uint32(Bytes.slice4(_blob, 40)));

    _table.obtainMethod = (uint8(Bytes.slice1(_blob, 44)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint256 catId,
    uint32 friendship,
    uint32 obtainTime,
    uint32 lostTime,
    uint8 obtainMethod
  ) internal view returns (bytes memory) {
    return abi.encodePacked(catId, friendship, obtainTime, lostTime, obtainMethod);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 userId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}