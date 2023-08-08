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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("PlayerInitConfig")));
bytes32 constant PlayerInitConfigTableId = _tableId;

struct PlayerInitConfigData {
  uint256 initCoins;
  bytes32[] initItems;
  uint32 initHungerCoinRate;
  uint32 initDropRate;
}

library PlayerInitConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](4);
    _schema[0] = SchemaType.UINT256;
    _schema[1] = SchemaType.BYTES32_ARRAY;
    _schema[2] = SchemaType.UINT32;
    _schema[3] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](0);

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](4);
    _fieldNames[0] = "initCoins";
    _fieldNames[1] = "initItems";
    _fieldNames[2] = "initHungerCoinRate";
    _fieldNames[3] = "initDropRate";
    return ("PlayerInitConfig", _fieldNames);
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

  /** Get initCoins */
  function getInitCoins() internal view returns (uint256 initCoins) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get initCoins (using the specified store) */
  function getInitCoins(IStore _store) internal view returns (uint256 initCoins) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set initCoins */
  function setInitCoins(uint256 initCoins) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((initCoins)));
  }

  /** Set initCoins (using the specified store) */
  function setInitCoins(IStore _store, uint256 initCoins) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((initCoins)));
  }

  /** Get initItems */
  function getInitItems() internal view returns (bytes32[] memory initItems) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Get initItems (using the specified store) */
  function getInitItems(IStore _store) internal view returns (bytes32[] memory initItems) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Set initItems */
  function setInitItems(bytes32[] memory initItems) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 1, EncodeArray.encode((initItems)));
  }

  /** Set initItems (using the specified store) */
  function setInitItems(IStore _store, bytes32[] memory initItems) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 1, EncodeArray.encode((initItems)));
  }

  /** Get the length of initItems */
  function lengthInitItems() internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of initItems (using the specified store) */
  function lengthInitItems(IStore _store) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of initItems (unchecked, returns invalid data if index overflows) */
  function getItemInitItems(uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get an item of initItems (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemInitItems(IStore _store, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Push an element to initItems */
  function pushInitItems(bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Push an element to initItems (using the specified store) */
  function pushInitItems(IStore _store, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Pop an element from initItems */
  function popInitItems() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.popFromField(_tableId, _keyTuple, 1, 32);
  }

  /** Pop an element from initItems (using the specified store) */
  function popInitItems(IStore _store) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.popFromField(_tableId, _keyTuple, 1, 32);
  }

  /** Update an element of initItems at `_index` */
  function updateInitItems(uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.updateInField(_tableId, _keyTuple, 1, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of initItems (using the specified store) at `_index` */
  function updateInitItems(IStore _store, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.updateInField(_tableId, _keyTuple, 1, _index * 32, abi.encodePacked((_element)));
  }

  /** Get initHungerCoinRate */
  function getInitHungerCoinRate() internal view returns (uint32 initHungerCoinRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get initHungerCoinRate (using the specified store) */
  function getInitHungerCoinRate(IStore _store) internal view returns (uint32 initHungerCoinRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set initHungerCoinRate */
  function setInitHungerCoinRate(uint32 initHungerCoinRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((initHungerCoinRate)));
  }

  /** Set initHungerCoinRate (using the specified store) */
  function setInitHungerCoinRate(IStore _store, uint32 initHungerCoinRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((initHungerCoinRate)));
  }

  /** Get initDropRate */
  function getInitDropRate() internal view returns (uint32 initDropRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get initDropRate (using the specified store) */
  function getInitDropRate(IStore _store) internal view returns (uint32 initDropRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set initDropRate */
  function setInitDropRate(uint32 initDropRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((initDropRate)));
  }

  /** Set initDropRate (using the specified store) */
  function setInitDropRate(IStore _store, uint32 initDropRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((initDropRate)));
  }

  /** Get the full data */
  function get() internal view returns (PlayerInitConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store) internal view returns (PlayerInitConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(uint256 initCoins, bytes32[] memory initItems, uint32 initHungerCoinRate, uint32 initDropRate) internal {
    bytes memory _data = encode(initCoins, initItems, initHungerCoinRate, initDropRate);

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    uint256 initCoins,
    bytes32[] memory initItems,
    uint32 initHungerCoinRate,
    uint32 initDropRate
  ) internal {
    bytes memory _data = encode(initCoins, initItems, initHungerCoinRate, initDropRate);

    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(PlayerInitConfigData memory _table) internal {
    set(_table.initCoins, _table.initItems, _table.initHungerCoinRate, _table.initDropRate);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, PlayerInitConfigData memory _table) internal {
    set(_store, _table.initCoins, _table.initItems, _table.initHungerCoinRate, _table.initDropRate);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (PlayerInitConfigData memory _table) {
    // 40 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 40));

    _table.initCoins = (uint256(Bytes.slice32(_blob, 0)));

    _table.initHungerCoinRate = (uint32(Bytes.slice4(_blob, 32)));

    _table.initDropRate = (uint32(Bytes.slice4(_blob, 36)));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 40) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 72;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.initItems = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_bytes32());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint256 initCoins,
    bytes32[] memory initItems,
    uint32 initHungerCoinRate,
    uint32 initDropRate
  ) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(initItems.length * 32);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        initCoins,
        initHungerCoinRate,
        initDropRate,
        _encodedLengths.unwrap(),
        EncodeArray.encode((initItems))
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple() internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](0);
  }

  /* Delete all data for given keys */
  function deleteRecord() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.deleteRecord(_tableId, _keyTuple);
  }
}