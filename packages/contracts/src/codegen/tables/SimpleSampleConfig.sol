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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("SimpleSampleConf")));
bytes32 constant SimpleSampleConfigTableId = _tableId;

library SimpleSampleConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT16_ARRAY;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "indices";
    return ("SimpleSampleConfig", _fieldNames);
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

  /** Get indices */
  function get(bytes32 sampleId) internal view returns (uint16[] memory indices) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Get indices (using the specified store) */
  function get(IStore _store, bytes32 sampleId) internal view returns (uint16[] memory indices) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Set indices */
  function set(bytes32 sampleId, uint16[] memory indices) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, EncodeArray.encode((indices)));
  }

  /** Set indices (using the specified store) */
  function set(IStore _store, bytes32 sampleId, uint16[] memory indices) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.setField(_tableId, _keyTuple, 0, EncodeArray.encode((indices)));
  }

  /** Get the length of indices */
  function length(bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 2;
  }

  /** Get the length of indices (using the specified store) */
  function length(IStore _store, bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 2;
  }

  /** Get an item of indices (unchecked, returns invalid data if index overflows) */
  function getItem(bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Get an item of indices (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItem(IStore _store, bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Push an element to indices */
  function push(bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Push an element to indices (using the specified store) */
  function push(IStore _store, bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Pop an element from indices */
  function pop(bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 0, 2);
  }

  /** Pop an element from indices (using the specified store) */
  function pop(IStore _store, bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.popFromField(_tableId, _keyTuple, 0, 2);
  }

  /** Update an element of indices at `_index` */
  function update(bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 0, _index * 2, abi.encodePacked((_element)));
  }

  /** Update an element of indices (using the specified store) at `_index` */
  function update(IStore _store, bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.updateInField(_tableId, _keyTuple, 0, _index * 2, abi.encodePacked((_element)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint16[] memory indices) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(indices.length * 2);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), EncodeArray.encode((indices)));
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 sampleId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}