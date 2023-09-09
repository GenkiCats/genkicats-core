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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("UserItems")));
bytes32 constant UserItemsTableId = _tableId;

struct UserItemsData {
  uint32 itemNum;
  uint8 itemStatus;
}

library UserItems {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.UINT8;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "itemNum";
    _fieldNames[1] = "itemStatus";
    return ("UserItems", _fieldNames);
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

  /** Get itemNum */
  function getItemNum(bytes32 userId, bytes32 itemId) internal view returns (uint32 itemNum) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemNum (using the specified store) */
  function getItemNum(IStore _store, bytes32 userId, bytes32 itemId) internal view returns (uint32 itemNum) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemNum */
  function setItemNum(bytes32 userId, bytes32 itemId, uint32 itemNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemNum)));
  }

  /** Set itemNum (using the specified store) */
  function setItemNum(IStore _store, bytes32 userId, bytes32 itemId, uint32 itemNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemNum)));
  }

  /** Get itemStatus */
  function getItemStatus(bytes32 userId, bytes32 itemId) internal view returns (uint8 itemStatus) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Get itemStatus (using the specified store) */
  function getItemStatus(IStore _store, bytes32 userId, bytes32 itemId) internal view returns (uint8 itemStatus) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Set itemStatus */
  function setItemStatus(bytes32 userId, bytes32 itemId, uint8 itemStatus) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemStatus)));
  }

  /** Set itemStatus (using the specified store) */
  function setItemStatus(IStore _store, bytes32 userId, bytes32 itemId, uint8 itemStatus) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemStatus)));
  }

  /** Get the full data */
  function get(bytes32 userId, bytes32 itemId) internal view returns (UserItemsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 userId, bytes32 itemId) internal view returns (UserItemsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 userId, bytes32 itemId, uint32 itemNum, uint8 itemStatus) internal {
    bytes memory _data = encode(itemNum, itemStatus);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 userId, bytes32 itemId, uint32 itemNum, uint8 itemStatus) internal {
    bytes memory _data = encode(itemNum, itemStatus);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 userId, bytes32 itemId, UserItemsData memory _table) internal {
    set(userId, itemId, _table.itemNum, _table.itemStatus);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 userId, bytes32 itemId, UserItemsData memory _table) internal {
    set(_store, userId, itemId, _table.itemNum, _table.itemStatus);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (UserItemsData memory _table) {
    _table.itemNum = (uint32(Bytes.slice4(_blob, 0)));

    _table.itemStatus = (uint8(Bytes.slice1(_blob, 4)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint32 itemNum, uint8 itemStatus) internal pure returns (bytes memory) {
    return abi.encodePacked(itemNum, itemStatus);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 userId, bytes32 itemId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 userId, bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 userId, bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = userId;
    _keyTuple[1] = itemId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
