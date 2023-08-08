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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("CatBuffEffectCon")));
bytes32 constant CatBuffEffectConfigTableId = _tableId;

struct CatBuffEffectConfigData {
  bytes32 buffId;
  uint256 buffEffectValue;
  uint256 duration;
  uint32 times;
  uint256[] extendedBuffEffectValues;
}

library CatBuffEffectConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](5);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.UINT256;
    _schema[2] = SchemaType.UINT256;
    _schema[3] = SchemaType.UINT32;
    _schema[4] = SchemaType.UINT256_ARRAY;

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
    _fieldNames[0] = "buffId";
    _fieldNames[1] = "buffEffectValue";
    _fieldNames[2] = "duration";
    _fieldNames[3] = "times";
    _fieldNames[4] = "extendedBuffEffectValues";
    return ("CatBuffEffectConfig", _fieldNames);
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

  /** Get buffId */
  function getBuffId(bytes32 buffEffectId) internal view returns (bytes32 buffId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get buffId (using the specified store) */
  function getBuffId(IStore _store, bytes32 buffEffectId) internal view returns (bytes32 buffId) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set buffId */
  function setBuffId(bytes32 buffEffectId, bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((buffId)));
  }

  /** Set buffId (using the specified store) */
  function setBuffId(IStore _store, bytes32 buffEffectId, bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((buffId)));
  }

  /** Get buffEffectValue */
  function getBuffEffectValue(bytes32 buffEffectId) internal view returns (uint256 buffEffectValue) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get buffEffectValue (using the specified store) */
  function getBuffEffectValue(IStore _store, bytes32 buffEffectId) internal view returns (uint256 buffEffectValue) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set buffEffectValue */
  function setBuffEffectValue(bytes32 buffEffectId, uint256 buffEffectValue) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((buffEffectValue)));
  }

  /** Set buffEffectValue (using the specified store) */
  function setBuffEffectValue(IStore _store, bytes32 buffEffectId, uint256 buffEffectValue) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((buffEffectValue)));
  }

  /** Get duration */
  function getDuration(bytes32 buffEffectId) internal view returns (uint256 duration) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get duration (using the specified store) */
  function getDuration(IStore _store, bytes32 buffEffectId) internal view returns (uint256 duration) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set duration */
  function setDuration(bytes32 buffEffectId, uint256 duration) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((duration)));
  }

  /** Set duration (using the specified store) */
  function setDuration(IStore _store, bytes32 buffEffectId, uint256 duration) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((duration)));
  }

  /** Get times */
  function getTimes(bytes32 buffEffectId) internal view returns (uint32 times) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get times (using the specified store) */
  function getTimes(IStore _store, bytes32 buffEffectId) internal view returns (uint32 times) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set times */
  function setTimes(bytes32 buffEffectId, uint32 times) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((times)));
  }

  /** Set times (using the specified store) */
  function setTimes(IStore _store, bytes32 buffEffectId, uint32 times) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((times)));
  }

  /** Get extendedBuffEffectValues */
  function getExtendedBuffEffectValues(
    bytes32 buffEffectId
  ) internal view returns (uint256[] memory extendedBuffEffectValues) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Get extendedBuffEffectValues (using the specified store) */
  function getExtendedBuffEffectValues(
    IStore _store,
    bytes32 buffEffectId
  ) internal view returns (uint256[] memory extendedBuffEffectValues) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Set extendedBuffEffectValues */
  function setExtendedBuffEffectValues(bytes32 buffEffectId, uint256[] memory extendedBuffEffectValues) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setField(_tableId, _keyTuple, 4, EncodeArray.encode((extendedBuffEffectValues)));
  }

  /** Set extendedBuffEffectValues (using the specified store) */
  function setExtendedBuffEffectValues(
    IStore _store,
    bytes32 buffEffectId,
    uint256[] memory extendedBuffEffectValues
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setField(_tableId, _keyTuple, 4, EncodeArray.encode((extendedBuffEffectValues)));
  }

  /** Get the length of extendedBuffEffectValues */
  function lengthExtendedBuffEffectValues(bytes32 buffEffectId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 4, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of extendedBuffEffectValues (using the specified store) */
  function lengthExtendedBuffEffectValues(IStore _store, bytes32 buffEffectId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 4, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of extendedBuffEffectValues (unchecked, returns invalid data if index overflows) */
  function getItemExtendedBuffEffectValues(bytes32 buffEffectId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 4, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get an item of extendedBuffEffectValues (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemExtendedBuffEffectValues(
    IStore _store,
    bytes32 buffEffectId,
    uint256 _index
  ) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 4, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Push an element to extendedBuffEffectValues */
  function pushExtendedBuffEffectValues(bytes32 buffEffectId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 4, abi.encodePacked((_element)));
  }

  /** Push an element to extendedBuffEffectValues (using the specified store) */
  function pushExtendedBuffEffectValues(IStore _store, bytes32 buffEffectId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.pushToField(_tableId, _keyTuple, 4, abi.encodePacked((_element)));
  }

  /** Pop an element from extendedBuffEffectValues */
  function popExtendedBuffEffectValues(bytes32 buffEffectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 4, 32);
  }

  /** Pop an element from extendedBuffEffectValues (using the specified store) */
  function popExtendedBuffEffectValues(IStore _store, bytes32 buffEffectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.popFromField(_tableId, _keyTuple, 4, 32);
  }

  /** Update an element of extendedBuffEffectValues at `_index` */
  function updateExtendedBuffEffectValues(bytes32 buffEffectId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 4, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of extendedBuffEffectValues (using the specified store) at `_index` */
  function updateExtendedBuffEffectValues(
    IStore _store,
    bytes32 buffEffectId,
    uint256 _index,
    uint256 _element
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.updateInField(_tableId, _keyTuple, 4, _index * 32, abi.encodePacked((_element)));
  }

  /** Get the full data */
  function get(bytes32 buffEffectId) internal view returns (CatBuffEffectConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 buffEffectId) internal view returns (CatBuffEffectConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 buffEffectId,
    bytes32 buffId,
    uint256 buffEffectValue,
    uint256 duration,
    uint32 times,
    uint256[] memory extendedBuffEffectValues
  ) internal {
    bytes memory _data = encode(buffId, buffEffectValue, duration, times, extendedBuffEffectValues);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 buffEffectId,
    bytes32 buffId,
    uint256 buffEffectValue,
    uint256 duration,
    uint32 times,
    uint256[] memory extendedBuffEffectValues
  ) internal {
    bytes memory _data = encode(buffId, buffEffectValue, duration, times, extendedBuffEffectValues);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 buffEffectId, CatBuffEffectConfigData memory _table) internal {
    set(
      buffEffectId,
      _table.buffId,
      _table.buffEffectValue,
      _table.duration,
      _table.times,
      _table.extendedBuffEffectValues
    );
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 buffEffectId, CatBuffEffectConfigData memory _table) internal {
    set(
      _store,
      buffEffectId,
      _table.buffId,
      _table.buffEffectValue,
      _table.duration,
      _table.times,
      _table.extendedBuffEffectValues
    );
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (CatBuffEffectConfigData memory _table) {
    // 100 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 100));

    _table.buffId = (Bytes.slice32(_blob, 0));

    _table.buffEffectValue = (uint256(Bytes.slice32(_blob, 32)));

    _table.duration = (uint256(Bytes.slice32(_blob, 64)));

    _table.times = (uint32(Bytes.slice4(_blob, 96)));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 100) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 132;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.extendedBuffEffectValues = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint256());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    bytes32 buffId,
    uint256 buffEffectValue,
    uint256 duration,
    uint32 times,
    uint256[] memory extendedBuffEffectValues
  ) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(extendedBuffEffectValues.length * 32);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        buffId,
        buffEffectValue,
        duration,
        times,
        _encodedLengths.unwrap(),
        EncodeArray.encode((extendedBuffEffectValues))
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 buffEffectId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 buffEffectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 buffEffectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffEffectId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
