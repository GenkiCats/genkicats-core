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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("TaskRequiredItem")));
bytes32 constant TaskRequiredItemsConfigTableId = _tableId;

struct TaskRequiredItemsConfigData {
  bytes32[] itemIds;
  uint32[] itemQuantities;
  bool[] isConsumed;
}

library TaskRequiredItemsConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.BYTES32_ARRAY;
    _schema[1] = SchemaType.UINT32_ARRAY;
    _schema[2] = SchemaType.BOOL_ARRAY;

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
    _fieldNames[0] = "itemIds";
    _fieldNames[1] = "itemQuantities";
    _fieldNames[2] = "isConsumed";
    return ("TaskRequiredItemsConfig", _fieldNames);
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

  /** Get itemIds */
  function getItemIds(bytes32 taskId) internal view returns (bytes32[] memory itemIds) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Get itemIds (using the specified store) */
  function getItemIds(IStore _store, bytes32 taskId) internal view returns (bytes32[] memory itemIds) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Set itemIds */
  function setItemIds(bytes32 taskId, bytes32[] memory itemIds) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, EncodeArray.encode((itemIds)));
  }

  /** Set itemIds (using the specified store) */
  function setItemIds(IStore _store, bytes32 taskId, bytes32[] memory itemIds) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.setField(_tableId, _keyTuple, 0, EncodeArray.encode((itemIds)));
  }

  /** Get the length of itemIds */
  function lengthItemIds(bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of itemIds (using the specified store) */
  function lengthItemIds(IStore _store, bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of itemIds (unchecked, returns invalid data if index overflows) */
  function getItemItemIds(bytes32 taskId, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get an item of itemIds (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemItemIds(IStore _store, bytes32 taskId, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Push an element to itemIds */
  function pushItemIds(bytes32 taskId, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Push an element to itemIds (using the specified store) */
  function pushItemIds(IStore _store, bytes32 taskId, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Pop an element from itemIds */
  function popItemIds(bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Pop an element from itemIds (using the specified store) */
  function popItemIds(IStore _store, bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Update an element of itemIds at `_index` */
  function updateItemIds(bytes32 taskId, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of itemIds (using the specified store) at `_index` */
  function updateItemIds(IStore _store, bytes32 taskId, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Get itemQuantities */
  function getItemQuantities(bytes32 taskId) internal view returns (uint32[] memory itemQuantities) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Get itemQuantities (using the specified store) */
  function getItemQuantities(IStore _store, bytes32 taskId) internal view returns (uint32[] memory itemQuantities) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /** Set itemQuantities */
  function setItemQuantities(bytes32 taskId, uint32[] memory itemQuantities) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, EncodeArray.encode((itemQuantities)));
  }

  /** Set itemQuantities (using the specified store) */
  function setItemQuantities(IStore _store, bytes32 taskId, uint32[] memory itemQuantities) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.setField(_tableId, _keyTuple, 1, EncodeArray.encode((itemQuantities)));
  }

  /** Get the length of itemQuantities */
  function lengthItemQuantities(bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 4;
  }

  /** Get the length of itemQuantities (using the specified store) */
  function lengthItemQuantities(IStore _store, bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 4;
  }

  /** Get an item of itemQuantities (unchecked, returns invalid data if index overflows) */
  function getItemItemQuantities(bytes32 taskId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 4, (_index + 1) * 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get an item of itemQuantities (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemItemQuantities(IStore _store, bytes32 taskId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 4, (_index + 1) * 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Push an element to itemQuantities */
  function pushItemQuantities(bytes32 taskId, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Push an element to itemQuantities (using the specified store) */
  function pushItemQuantities(IStore _store, bytes32 taskId, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Pop an element from itemQuantities */
  function popItemQuantities(bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 1, 4);
  }

  /** Pop an element from itemQuantities (using the specified store) */
  function popItemQuantities(IStore _store, bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.popFromField(_tableId, _keyTuple, 1, 4);
  }

  /** Update an element of itemQuantities at `_index` */
  function updateItemQuantities(bytes32 taskId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 1, _index * 4, abi.encodePacked((_element)));
  }

  /** Update an element of itemQuantities (using the specified store) at `_index` */
  function updateItemQuantities(IStore _store, bytes32 taskId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.updateInField(_tableId, _keyTuple, 1, _index * 4, abi.encodePacked((_element)));
  }

  /** Get isConsumed */
  function getIsConsumed(bytes32 taskId) internal view returns (bool[] memory isConsumed) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bool());
  }

  /** Get isConsumed (using the specified store) */
  function getIsConsumed(IStore _store, bytes32 taskId) internal view returns (bool[] memory isConsumed) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bool());
  }

  /** Set isConsumed */
  function setIsConsumed(bytes32 taskId, bool[] memory isConsumed) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, EncodeArray.encode((isConsumed)));
  }

  /** Set isConsumed (using the specified store) */
  function setIsConsumed(IStore _store, bytes32 taskId, bool[] memory isConsumed) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.setField(_tableId, _keyTuple, 2, EncodeArray.encode((isConsumed)));
  }

  /** Get the length of isConsumed */
  function lengthIsConsumed(bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 2, getSchema());
    return _byteLength / 1;
  }

  /** Get the length of isConsumed (using the specified store) */
  function lengthIsConsumed(IStore _store, bytes32 taskId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 2, getSchema());
    return _byteLength / 1;
  }

  /** Get an item of isConsumed (unchecked, returns invalid data if index overflows) */
  function getItemIsConsumed(bytes32 taskId, uint256 _index) internal view returns (bool) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 2, getSchema(), _index * 1, (_index + 1) * 1);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Get an item of isConsumed (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemIsConsumed(IStore _store, bytes32 taskId, uint256 _index) internal view returns (bool) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 2, getSchema(), _index * 1, (_index + 1) * 1);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Push an element to isConsumed */
  function pushIsConsumed(bytes32 taskId, bool _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 2, abi.encodePacked((_element)));
  }

  /** Push an element to isConsumed (using the specified store) */
  function pushIsConsumed(IStore _store, bytes32 taskId, bool _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.pushToField(_tableId, _keyTuple, 2, abi.encodePacked((_element)));
  }

  /** Pop an element from isConsumed */
  function popIsConsumed(bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 2, 1);
  }

  /** Pop an element from isConsumed (using the specified store) */
  function popIsConsumed(IStore _store, bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.popFromField(_tableId, _keyTuple, 2, 1);
  }

  /** Update an element of isConsumed at `_index` */
  function updateIsConsumed(bytes32 taskId, uint256 _index, bool _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 2, _index * 1, abi.encodePacked((_element)));
  }

  /** Update an element of isConsumed (using the specified store) at `_index` */
  function updateIsConsumed(IStore _store, bytes32 taskId, uint256 _index, bool _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.updateInField(_tableId, _keyTuple, 2, _index * 1, abi.encodePacked((_element)));
  }

  /** Get the full data */
  function get(bytes32 taskId) internal view returns (TaskRequiredItemsConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 taskId) internal view returns (TaskRequiredItemsConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 taskId,
    bytes32[] memory itemIds,
    uint32[] memory itemQuantities,
    bool[] memory isConsumed
  ) internal {
    bytes memory _data = encode(itemIds, itemQuantities, isConsumed);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 taskId,
    bytes32[] memory itemIds,
    uint32[] memory itemQuantities,
    bool[] memory isConsumed
  ) internal {
    bytes memory _data = encode(itemIds, itemQuantities, isConsumed);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 taskId, TaskRequiredItemsConfigData memory _table) internal {
    set(taskId, _table.itemIds, _table.itemQuantities, _table.isConsumed);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 taskId, TaskRequiredItemsConfigData memory _table) internal {
    set(_store, taskId, _table.itemIds, _table.itemQuantities, _table.isConsumed);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (TaskRequiredItemsConfigData memory _table) {
    // 0 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 0));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 0) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 32;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.itemIds = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_bytes32());

      _start = _end;
      _end += _encodedLengths.atIndex(1);
      _table.itemQuantities = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());

      _start = _end;
      _end += _encodedLengths.atIndex(2);
      _table.isConsumed = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_bool());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    bytes32[] memory itemIds,
    uint32[] memory itemQuantities,
    bool[] memory isConsumed
  ) internal pure returns (bytes memory) {
    uint40[] memory _counters = new uint40[](3);
    _counters[0] = uint40(itemIds.length * 32);
    _counters[1] = uint40(itemQuantities.length * 4);
    _counters[2] = uint40(isConsumed.length * 1);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        _encodedLengths.unwrap(),
        EncodeArray.encode((itemIds)),
        EncodeArray.encode((itemQuantities)),
        EncodeArray.encode((isConsumed))
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 taskId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 taskId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = taskId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}

function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}