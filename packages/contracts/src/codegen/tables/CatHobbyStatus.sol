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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("CatHobbyStatus")));
bytes32 constant CatHobbyStatusTableId = _tableId;

struct CatHobbyStatusData {
  bytes32 currentLogId;
  bytes32 latestLogId;
  uint256 lastEventFinishTime;
}

library CatHobbyStatus {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.BYTES32;
    _schema[2] = SchemaType.UINT256;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](3);
    _fieldNames[0] = "currentLogId";
    _fieldNames[1] = "latestLogId";
    _fieldNames[2] = "lastEventFinishTime";
    return ("CatHobbyStatus", _fieldNames);
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

  /** Get currentLogId */
  function getCurrentLogId(bytes32 catId) internal view returns (bytes32 currentLogId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get currentLogId (using the specified store) */
  function getCurrentLogId(IStore _store, bytes32 catId) internal view returns (bytes32 currentLogId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set currentLogId */
  function setCurrentLogId(bytes32 catId, bytes32 currentLogId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((currentLogId)));
  }

  /** Set currentLogId (using the specified store) */
  function setCurrentLogId(IStore _store, bytes32 catId, bytes32 currentLogId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((currentLogId)));
  }

  /** Get latestLogId */
  function getLatestLogId(bytes32 catId) internal view returns (bytes32 latestLogId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get latestLogId (using the specified store) */
  function getLatestLogId(IStore _store, bytes32 catId) internal view returns (bytes32 latestLogId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set latestLogId */
  function setLatestLogId(bytes32 catId, bytes32 latestLogId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((latestLogId)));
  }

  /** Set latestLogId (using the specified store) */
  function setLatestLogId(IStore _store, bytes32 catId, bytes32 latestLogId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((latestLogId)));
  }

  /** Get lastEventFinishTime */
  function getLastEventFinishTime(bytes32 catId) internal view returns (uint256 lastEventFinishTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get lastEventFinishTime (using the specified store) */
  function getLastEventFinishTime(IStore _store, bytes32 catId) internal view returns (uint256 lastEventFinishTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set lastEventFinishTime */
  function setLastEventFinishTime(bytes32 catId, uint256 lastEventFinishTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((lastEventFinishTime)));
  }

  /** Set lastEventFinishTime (using the specified store) */
  function setLastEventFinishTime(IStore _store, bytes32 catId, uint256 lastEventFinishTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((lastEventFinishTime)));
  }

  /** Get the full data */
  function get(bytes32 catId) internal view returns (CatHobbyStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 catId) internal view returns (CatHobbyStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 catId, bytes32 currentLogId, bytes32 latestLogId, uint256 lastEventFinishTime) internal {
    bytes memory _data = encode(currentLogId, latestLogId, lastEventFinishTime);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 catId,
    bytes32 currentLogId,
    bytes32 latestLogId,
    uint256 lastEventFinishTime
  ) internal {
    bytes memory _data = encode(currentLogId, latestLogId, lastEventFinishTime);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 catId, CatHobbyStatusData memory _table) internal {
    set(catId, _table.currentLogId, _table.latestLogId, _table.lastEventFinishTime);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 catId, CatHobbyStatusData memory _table) internal {
    set(_store, catId, _table.currentLogId, _table.latestLogId, _table.lastEventFinishTime);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (CatHobbyStatusData memory _table) {
    _table.currentLogId = (Bytes.slice32(_blob, 0));

    _table.latestLogId = (Bytes.slice32(_blob, 32));

    _table.lastEventFinishTime = (uint256(Bytes.slice32(_blob, 64)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    bytes32 currentLogId,
    bytes32 latestLogId,
    uint256 lastEventFinishTime
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(currentLogId, latestLogId, lastEventFinishTime);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 catId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 catId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 catId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
