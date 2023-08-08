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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("ItemList")));
bytes32 constant ItemListTableId = _tableId;

struct ItemListData {
  bytes32 itemId;
  uint256 itemNum;
}

library ItemList {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.UINT256;

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
    _fieldNames[0] = "itemId";
    _fieldNames[1] = "itemNum";
    return ("ItemList", _fieldNames);
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

  /** Get itemId */
  function getItemId(bytes32 event_hash) internal view returns (bytes32 itemId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get itemId (using the specified store) */
  function getItemId(IStore _store, bytes32 event_hash) internal view returns (bytes32 itemId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set itemId */
  function setItemId(bytes32 event_hash, bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemId)));
  }

  /** Set itemId (using the specified store) */
  function setItemId(IStore _store, bytes32 event_hash, bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemId)));
  }

  /** Get itemNum */
  function getItemNum(bytes32 event_hash) internal view returns (uint256 itemNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get itemNum (using the specified store) */
  function getItemNum(IStore _store, bytes32 event_hash) internal view returns (uint256 itemNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set itemNum */
  function setItemNum(bytes32 event_hash, uint256 itemNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemNum)));
  }

  /** Set itemNum (using the specified store) */
  function setItemNum(IStore _store, bytes32 event_hash, uint256 itemNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemNum)));
  }

  /** Get the full data */
  function get(bytes32 event_hash) internal view returns (ItemListData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 event_hash) internal view returns (ItemListData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 event_hash, bytes32 itemId, uint256 itemNum) internal {
    bytes memory _data = encode(itemId, itemNum);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 event_hash, bytes32 itemId, uint256 itemNum) internal {
    bytes memory _data = encode(itemId, itemNum);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 event_hash, ItemListData memory _table) internal {
    set(event_hash, _table.itemId, _table.itemNum);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 event_hash, ItemListData memory _table) internal {
    set(_store, event_hash, _table.itemId, _table.itemNum);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (ItemListData memory _table) {
    _table.itemId = (Bytes.slice32(_blob, 0));

    _table.itemNum = (uint256(Bytes.slice32(_blob, 32)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bytes32 itemId, uint256 itemNum) internal view returns (bytes memory) {
    return abi.encodePacked(itemId, itemNum);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 event_hash) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 event_hash) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 event_hash) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = event_hash;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
