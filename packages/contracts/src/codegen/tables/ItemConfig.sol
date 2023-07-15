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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("ItemConfig")));
bytes32 constant ItemConfigTableId = _tableId;

struct ItemConfigData {
  uint32 maxHoldNum;
  string name;
}

library ItemConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.STRING;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT256;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "maxHoldNum";
    _fieldNames[1] = "name";
    return ("ItemConfig", _fieldNames);
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

  /** Get maxHoldNum */
  function getMaxHoldNum(uint256 itemId) internal view returns (uint32 maxHoldNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get maxHoldNum (using the specified store) */
  function getMaxHoldNum(IStore _store, uint256 itemId) internal view returns (uint32 maxHoldNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set maxHoldNum */
  function setMaxHoldNum(uint256 itemId, uint32 maxHoldNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((maxHoldNum)));
  }

  /** Set maxHoldNum (using the specified store) */
  function setMaxHoldNum(IStore _store, uint256 itemId, uint32 maxHoldNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((maxHoldNum)));
  }

  /** Get name */
  function getName(uint256 itemId) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /** Get name (using the specified store) */
  function getName(IStore _store, uint256 itemId) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /** Set name */
  function setName(uint256 itemId, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.setField(_tableId, _keyTuple, 1, bytes((name)));
  }

  /** Set name (using the specified store) */
  function setName(IStore _store, uint256 itemId, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.setField(_tableId, _keyTuple, 1, bytes((name)));
  }

  /** Get the length of name */
  function lengthName(uint256 itemId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 1;
  }

  /** Get the length of name (using the specified store) */
  function lengthName(IStore _store, uint256 itemId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 1;
  }

  /** Get an item of name (unchecked, returns invalid data if index overflows) */
  function getItemName(uint256 itemId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Get an item of name (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemName(IStore _store, uint256 itemId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Push a slice to name */
  function pushName(uint256 itemId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.pushToField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /** Push a slice to name (using the specified store) */
  function pushName(IStore _store, uint256 itemId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.pushToField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /** Pop a slice from name */
  function popName(uint256 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.popFromField(_tableId, _keyTuple, 1, 1);
  }

  /** Pop a slice from name (using the specified store) */
  function popName(IStore _store, uint256 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.popFromField(_tableId, _keyTuple, 1, 1);
  }

  /** Update a slice of name at `_index` */
  function updateName(uint256 itemId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.updateInField(_tableId, _keyTuple, 1, _index * 1, bytes((_slice)));
  }

  /** Update a slice of name (using the specified store) at `_index` */
  function updateName(IStore _store, uint256 itemId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.updateInField(_tableId, _keyTuple, 1, _index * 1, bytes((_slice)));
  }

  /** Get the full data */
  function get(uint256 itemId) internal view returns (ItemConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, uint256 itemId) internal view returns (ItemConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(uint256 itemId, uint32 maxHoldNum, string memory name) internal {
    bytes memory _data = encode(maxHoldNum, name);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, uint256 itemId, uint32 maxHoldNum, string memory name) internal {
    bytes memory _data = encode(maxHoldNum, name);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(uint256 itemId, ItemConfigData memory _table) internal {
    set(itemId, _table.maxHoldNum, _table.name);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, uint256 itemId, ItemConfigData memory _table) internal {
    set(_store, itemId, _table.maxHoldNum, _table.name);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (ItemConfigData memory _table) {
    // 4 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 4));

    _table.maxHoldNum = (uint32(Bytes.slice4(_blob, 0)));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 4) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 36;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.name = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint32 maxHoldNum, string memory name) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(bytes(name).length);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(maxHoldNum, _encodedLengths.unwrap(), bytes((name)));
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(uint256 itemId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));
  }

  /* Delete all data for given keys */
  function deleteRecord(uint256 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, uint256 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(itemId));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}