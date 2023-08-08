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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("CatBuffConfig")));
bytes32 constant CatBuffConfigTableId = _tableId;

struct CatBuffConfigData {
  uint32 buffType;
  uint256 attribute;
  uint256[] extendedAttributes;
}

library CatBuffConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.UINT256;
    _schema[2] = SchemaType.UINT256_ARRAY;

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
    _fieldNames[0] = "buffType";
    _fieldNames[1] = "attribute";
    _fieldNames[2] = "extendedAttributes";
    return ("CatBuffConfig", _fieldNames);
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

  /** Get buffType */
  function getBuffType(bytes32 buffId) internal view returns (uint32 buffType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get buffType (using the specified store) */
  function getBuffType(IStore _store, bytes32 buffId) internal view returns (uint32 buffType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set buffType */
  function setBuffType(bytes32 buffId, uint32 buffType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((buffType)));
  }

  /** Set buffType (using the specified store) */
  function setBuffType(IStore _store, bytes32 buffId, uint32 buffType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((buffType)));
  }

  /** Get attribute */
  function getAttribute(bytes32 buffId) internal view returns (uint256 attribute) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get attribute (using the specified store) */
  function getAttribute(IStore _store, bytes32 buffId) internal view returns (uint256 attribute) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set attribute */
  function setAttribute(bytes32 buffId, uint256 attribute) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((attribute)));
  }

  /** Set attribute (using the specified store) */
  function setAttribute(IStore _store, bytes32 buffId, uint256 attribute) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((attribute)));
  }

  /** Get extendedAttributes */
  function getExtendedAttributes(bytes32 buffId) internal view returns (uint256[] memory extendedAttributes) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Get extendedAttributes (using the specified store) */
  function getExtendedAttributes(
    IStore _store,
    bytes32 buffId
  ) internal view returns (uint256[] memory extendedAttributes) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Set extendedAttributes */
  function setExtendedAttributes(bytes32 buffId, uint256[] memory extendedAttributes) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, EncodeArray.encode((extendedAttributes)));
  }

  /** Set extendedAttributes (using the specified store) */
  function setExtendedAttributes(IStore _store, bytes32 buffId, uint256[] memory extendedAttributes) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.setField(_tableId, _keyTuple, 2, EncodeArray.encode((extendedAttributes)));
  }

  /** Get the length of extendedAttributes */
  function lengthExtendedAttributes(bytes32 buffId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 2, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of extendedAttributes (using the specified store) */
  function lengthExtendedAttributes(IStore _store, bytes32 buffId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 2, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of extendedAttributes (unchecked, returns invalid data if index overflows) */
  function getItemExtendedAttributes(bytes32 buffId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 2, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get an item of extendedAttributes (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemExtendedAttributes(IStore _store, bytes32 buffId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 2, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Push an element to extendedAttributes */
  function pushExtendedAttributes(bytes32 buffId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 2, abi.encodePacked((_element)));
  }

  /** Push an element to extendedAttributes (using the specified store) */
  function pushExtendedAttributes(IStore _store, bytes32 buffId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.pushToField(_tableId, _keyTuple, 2, abi.encodePacked((_element)));
  }

  /** Pop an element from extendedAttributes */
  function popExtendedAttributes(bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 2, 32);
  }

  /** Pop an element from extendedAttributes (using the specified store) */
  function popExtendedAttributes(IStore _store, bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.popFromField(_tableId, _keyTuple, 2, 32);
  }

  /** Update an element of extendedAttributes at `_index` */
  function updateExtendedAttributes(bytes32 buffId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 2, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of extendedAttributes (using the specified store) at `_index` */
  function updateExtendedAttributes(IStore _store, bytes32 buffId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.updateInField(_tableId, _keyTuple, 2, _index * 32, abi.encodePacked((_element)));
  }

  /** Get the full data */
  function get(bytes32 buffId) internal view returns (CatBuffConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 buffId) internal view returns (CatBuffConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 buffId, uint32 buffType, uint256 attribute, uint256[] memory extendedAttributes) internal {
    bytes memory _data = encode(buffType, attribute, extendedAttributes);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 buffId,
    uint32 buffType,
    uint256 attribute,
    uint256[] memory extendedAttributes
  ) internal {
    bytes memory _data = encode(buffType, attribute, extendedAttributes);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 buffId, CatBuffConfigData memory _table) internal {
    set(buffId, _table.buffType, _table.attribute, _table.extendedAttributes);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 buffId, CatBuffConfigData memory _table) internal {
    set(_store, buffId, _table.buffType, _table.attribute, _table.extendedAttributes);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (CatBuffConfigData memory _table) {
    // 36 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 36));

    _table.buffType = (uint32(Bytes.slice4(_blob, 0)));

    _table.attribute = (uint256(Bytes.slice32(_blob, 4)));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 36) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 68;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.extendedAttributes = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint256());
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint32 buffType,
    uint256 attribute,
    uint256[] memory extendedAttributes
  ) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(extendedAttributes.length * 32);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(buffType, attribute, _encodedLengths.unwrap(), EncodeArray.encode((extendedAttributes)));
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 buffId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 buffId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = buffId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
