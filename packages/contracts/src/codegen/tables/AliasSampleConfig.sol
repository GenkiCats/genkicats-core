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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("AliasSampleConfi")));
bytes32 constant AliasSampleConfigTableId = _tableId;

struct AliasSampleConfigData {
  uint16[] rates;
  uint16[] indices;
}

library AliasSampleConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT16_ARRAY;
    _schema[1] = SchemaType.UINT16_ARRAY;

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
    _fieldNames[0] = "rates";
    _fieldNames[1] = "indices";
    return ("AliasSampleConfig", _fieldNames);
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

  /** Get rates */
  function getRates(bytes32 sampleId) internal view returns (uint16[] memory rates) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Get rates (using the specified store) */
  function getRates(IStore _store, bytes32 sampleId) internal view returns (uint16[] memory rates) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Set rates */
  function setRates(bytes32 sampleId, uint16[] memory rates) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, EncodeArray.encode((rates)));
  }

  /** Set rates (using the specified store) */
  function setRates(IStore _store, bytes32 sampleId, uint16[] memory rates) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.setField(_tableId, _keyTuple, 0, EncodeArray.encode((rates)));
  }

  /** Get the length of rates */
  function lengthRates(bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 2;
  }

  /** Get the length of rates (using the specified store) */
  function lengthRates(IStore _store, bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 2;
  }

  /** Get an item of rates (unchecked, returns invalid data if index overflows) */
  function getItemRates(bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Get an item of rates (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemRates(IStore _store, bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Push an element to rates */
  function pushRates(bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Push an element to rates (using the specified store) */
  function pushRates(IStore _store, bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Pop an element from rates */
  function popRates(bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 0, 2);
  }

  /** Pop an element from rates (using the specified store) */
  function popRates(IStore _store, bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.popFromField(_tableId, _keyTuple, 0, 2);
  }

  /** Update an element of rates at `_index` */
  function updateRates(bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 0, _index * 2, abi.encodePacked((_element)));
  }

  /** Update an element of rates (using the specified store) at `_index` */
  function updateRates(IStore _store, bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.updateInField(_tableId, _keyTuple, 0, _index * 2, abi.encodePacked((_element)));
  }

  /** Get indices */
  function getIndices(bytes32 sampleId) internal view returns (uint16[] memory indices) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Get indices (using the specified store) */
  function getIndices(IStore _store, bytes32 sampleId) internal view returns (uint16[] memory indices) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint16());
  }

  /** Set indices */
  function setIndices(bytes32 sampleId, uint16[] memory indices) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, EncodeArray.encode((indices)));
  }

  /** Set indices (using the specified store) */
  function setIndices(IStore _store, bytes32 sampleId, uint16[] memory indices) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.setField(_tableId, _keyTuple, 1, EncodeArray.encode((indices)));
  }

  /** Get the length of indices */
  function lengthIndices(bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 2;
  }

  /** Get the length of indices (using the specified store) */
  function lengthIndices(IStore _store, bytes32 sampleId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 1, getSchema());
    return _byteLength / 2;
  }

  /** Get an item of indices (unchecked, returns invalid data if index overflows) */
  function getItemIndices(bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Get an item of indices (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemIndices(IStore _store, bytes32 sampleId, uint256 _index) internal view returns (uint16) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 1, getSchema(), _index * 2, (_index + 1) * 2);
    return (uint16(Bytes.slice2(_blob, 0)));
  }

  /** Push an element to indices */
  function pushIndices(bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Push an element to indices (using the specified store) */
  function pushIndices(IStore _store, bytes32 sampleId, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.pushToField(_tableId, _keyTuple, 1, abi.encodePacked((_element)));
  }

  /** Pop an element from indices */
  function popIndices(bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 1, 2);
  }

  /** Pop an element from indices (using the specified store) */
  function popIndices(IStore _store, bytes32 sampleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.popFromField(_tableId, _keyTuple, 1, 2);
  }

  /** Update an element of indices at `_index` */
  function updateIndices(bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 1, _index * 2, abi.encodePacked((_element)));
  }

  /** Update an element of indices (using the specified store) at `_index` */
  function updateIndices(IStore _store, bytes32 sampleId, uint256 _index, uint16 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.updateInField(_tableId, _keyTuple, 1, _index * 2, abi.encodePacked((_element)));
  }

  /** Get the full data */
  function get(bytes32 sampleId) internal view returns (AliasSampleConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 sampleId) internal view returns (AliasSampleConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 sampleId, uint16[] memory rates, uint16[] memory indices) internal {
    bytes memory _data = encode(rates, indices);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 sampleId, uint16[] memory rates, uint16[] memory indices) internal {
    bytes memory _data = encode(rates, indices);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = sampleId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 sampleId, AliasSampleConfigData memory _table) internal {
    set(sampleId, _table.rates, _table.indices);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 sampleId, AliasSampleConfigData memory _table) internal {
    set(_store, sampleId, _table.rates, _table.indices);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (AliasSampleConfigData memory _table) {
    // 0 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 0));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 0) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 32;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.rates = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint16());

      _start = _end;
      _end += _encodedLengths.atIndex(1);
      _table.indices = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint16());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint16[] memory rates, uint16[] memory indices) internal pure returns (bytes memory) {
    uint40[] memory _counters = new uint40[](2);
    _counters[0] = uint40(rates.length * 2);
    _counters[1] = uint40(indices.length * 2);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), EncodeArray.encode((rates)), EncodeArray.encode((indices)));
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
