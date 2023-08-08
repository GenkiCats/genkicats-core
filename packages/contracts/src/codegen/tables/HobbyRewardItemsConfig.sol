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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("HobbyRewardItems")));
bytes32 constant HobbyRewardItemsConfigTableId = _tableId;

library HobbyRewardItemsConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32_ARRAY;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.UINT8;
    _schema[2] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "itemIds";
    return ("HobbyRewardItemsConfig", _fieldNames);
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
  function get(bytes32 hobbyId, uint8 tier, bytes32 tagId) internal view returns (bytes32[] memory itemIds) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Get itemIds (using the specified store) */
  function get(
    IStore _store,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId
  ) internal view returns (bytes32[] memory itemIds) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Set itemIds */
  function set(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32[] memory itemIds) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, EncodeArray.encode((itemIds)));
  }

  /** Set itemIds (using the specified store) */
  function set(IStore _store, bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32[] memory itemIds) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    _store.setField(_tableId, _keyTuple, 0, EncodeArray.encode((itemIds)));
  }

  /** Get the length of itemIds */
  function length(bytes32 hobbyId, uint8 tier, bytes32 tagId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of itemIds (using the specified store) */
  function length(IStore _store, bytes32 hobbyId, uint8 tier, bytes32 tagId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of itemIds (unchecked, returns invalid data if index overflows) */
  function getItem(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get an item of itemIds (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItem(
    IStore _store,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 _index
  ) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Push an element to itemIds */
  function push(bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Push an element to itemIds (using the specified store) */
  function push(IStore _store, bytes32 hobbyId, uint8 tier, bytes32 tagId, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    _store.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Pop an element from itemIds */
  function pop(bytes32 hobbyId, uint8 tier, bytes32 tagId) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Pop an element from itemIds (using the specified store) */
  function pop(IStore _store, bytes32 hobbyId, uint8 tier, bytes32 tagId) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    _store.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Update an element of itemIds at `_index` */
  function update(bytes32 hobbyId, uint8 tier, bytes32 tagId, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of itemIds (using the specified store) at `_index` */
  function update(
    IStore _store,
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId,
    uint256 _index,
    bytes32 _element
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    _store.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bytes32[] memory itemIds) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(itemIds.length * 32);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), EncodeArray.encode((itemIds)));
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(
    bytes32 hobbyId,
    uint8 tier,
    bytes32 tagId
  ) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 hobbyId, uint8 tier, bytes32 tagId) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 hobbyId, uint8 tier, bytes32 tagId) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = hobbyId;
    _keyTuple[1] = bytes32(uint256(tier));
    _keyTuple[2] = tagId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
