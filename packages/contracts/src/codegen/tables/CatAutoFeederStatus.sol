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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("CatAutoFeederSta")));
bytes32 constant CatAutoFeederStatusTableId = _tableId;

struct CatAutoFeederStatusData {
  uint256 lastAutoFeedTime;
  uint32 autoFeedRatio;
}

library CatAutoFeederStatus {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT256;
    _schema[1] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "lastAutoFeedTime";
    _fieldNames[1] = "autoFeedRatio";
    return ("CatAutoFeederStatus", _fieldNames);
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

  /** Get lastAutoFeedTime */
  function getLastAutoFeedTime(bytes32 catId) internal view returns (uint256 lastAutoFeedTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get lastAutoFeedTime (using the specified store) */
  function getLastAutoFeedTime(IStore _store, bytes32 catId) internal view returns (uint256 lastAutoFeedTime) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set lastAutoFeedTime */
  function setLastAutoFeedTime(bytes32 catId, uint256 lastAutoFeedTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((lastAutoFeedTime)));
  }

  /** Set lastAutoFeedTime (using the specified store) */
  function setLastAutoFeedTime(IStore _store, bytes32 catId, uint256 lastAutoFeedTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((lastAutoFeedTime)));
  }

  /** Get autoFeedRatio */
  function getAutoFeedRatio(bytes32 catId) internal view returns (uint32 autoFeedRatio) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get autoFeedRatio (using the specified store) */
  function getAutoFeedRatio(IStore _store, bytes32 catId) internal view returns (uint32 autoFeedRatio) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set autoFeedRatio */
  function setAutoFeedRatio(bytes32 catId, uint32 autoFeedRatio) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((autoFeedRatio)));
  }

  /** Set autoFeedRatio (using the specified store) */
  function setAutoFeedRatio(IStore _store, bytes32 catId, uint32 autoFeedRatio) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((autoFeedRatio)));
  }

  /** Get the full data */
  function get(bytes32 catId) internal view returns (CatAutoFeederStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 catId) internal view returns (CatAutoFeederStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 catId, uint256 lastAutoFeedTime, uint32 autoFeedRatio) internal {
    bytes memory _data = encode(lastAutoFeedTime, autoFeedRatio);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 catId, uint256 lastAutoFeedTime, uint32 autoFeedRatio) internal {
    bytes memory _data = encode(lastAutoFeedTime, autoFeedRatio);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = catId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 catId, CatAutoFeederStatusData memory _table) internal {
    set(catId, _table.lastAutoFeedTime, _table.autoFeedRatio);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 catId, CatAutoFeederStatusData memory _table) internal {
    set(_store, catId, _table.lastAutoFeedTime, _table.autoFeedRatio);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (CatAutoFeederStatusData memory _table) {
    _table.lastAutoFeedTime = (uint256(Bytes.slice32(_blob, 0)));

    _table.autoFeedRatio = (uint32(Bytes.slice4(_blob, 32)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint256 lastAutoFeedTime, uint32 autoFeedRatio) internal view returns (bytes memory) {
    return abi.encodePacked(lastAutoFeedTime, autoFeedRatio);
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
