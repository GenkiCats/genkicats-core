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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("ChoresConfig")));
bytes32 constant ChoresConfigTableId = _tableId;

struct ChoresConfigData {
  uint8 choreType;
  uint256 choreReward;
  uint8 choreRewardType;
  bytes32 choreRewardItemsHash;
  uint256[] choreRewardItems;
  uint256[] choreRewardItemsNum;
  string choreName;
  string choreDescription;
}

library ChoresConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](8);
    _schema[0] = SchemaType.UINT8;
    _schema[1] = SchemaType.UINT256;
    _schema[2] = SchemaType.UINT8;
    _schema[3] = SchemaType.BYTES32;
    _schema[4] = SchemaType.UINT256_ARRAY;
    _schema[5] = SchemaType.UINT256_ARRAY;
    _schema[6] = SchemaType.STRING;
    _schema[7] = SchemaType.STRING;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT256;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](8);
    _fieldNames[0] = "choreType";
    _fieldNames[1] = "choreReward";
    _fieldNames[2] = "choreRewardType";
    _fieldNames[3] = "choreRewardItemsHash";
    _fieldNames[4] = "choreRewardItems";
    _fieldNames[5] = "choreRewardItemsNum";
    _fieldNames[6] = "choreName";
    _fieldNames[7] = "choreDescription";
    return ("ChoresConfig", _fieldNames);
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

  /** Get choreType */
  function getChoreType(uint256 choreId) internal view returns (uint8 choreType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Get choreType (using the specified store) */
  function getChoreType(IStore _store, uint256 choreId) internal view returns (uint8 choreType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Set choreType */
  function setChoreType(uint256 choreId, uint8 choreType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((choreType)));
  }

  /** Set choreType (using the specified store) */
  function setChoreType(IStore _store, uint256 choreId, uint8 choreType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((choreType)));
  }

  /** Get choreReward */
  function getChoreReward(uint256 choreId) internal view returns (uint256 choreReward) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get choreReward (using the specified store) */
  function getChoreReward(IStore _store, uint256 choreId) internal view returns (uint256 choreReward) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set choreReward */
  function setChoreReward(uint256 choreId, uint256 choreReward) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((choreReward)));
  }

  /** Set choreReward (using the specified store) */
  function setChoreReward(IStore _store, uint256 choreId, uint256 choreReward) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((choreReward)));
  }

  /** Get choreRewardType */
  function getChoreRewardType(uint256 choreId) internal view returns (uint8 choreRewardType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Get choreRewardType (using the specified store) */
  function getChoreRewardType(IStore _store, uint256 choreId) internal view returns (uint8 choreRewardType) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint8(Bytes.slice1(_blob, 0)));
  }

  /** Set choreRewardType */
  function setChoreRewardType(uint256 choreId, uint8 choreRewardType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((choreRewardType)));
  }

  /** Set choreRewardType (using the specified store) */
  function setChoreRewardType(IStore _store, uint256 choreId, uint8 choreRewardType) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((choreRewardType)));
  }

  /** Get choreRewardItemsHash */
  function getChoreRewardItemsHash(uint256 choreId) internal view returns (bytes32 choreRewardItemsHash) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get choreRewardItemsHash (using the specified store) */
  function getChoreRewardItemsHash(
    IStore _store,
    uint256 choreId
  ) internal view returns (bytes32 choreRewardItemsHash) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (Bytes.slice32(_blob, 0));
  }

  /** Set choreRewardItemsHash */
  function setChoreRewardItemsHash(uint256 choreId, bytes32 choreRewardItemsHash) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((choreRewardItemsHash)));
  }

  /** Set choreRewardItemsHash (using the specified store) */
  function setChoreRewardItemsHash(IStore _store, uint256 choreId, bytes32 choreRewardItemsHash) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((choreRewardItemsHash)));
  }

  /** Get choreRewardItems */
  function getChoreRewardItems(uint256 choreId) internal view returns (uint256[] memory choreRewardItems) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Get choreRewardItems (using the specified store) */
  function getChoreRewardItems(
    IStore _store,
    uint256 choreId
  ) internal view returns (uint256[] memory choreRewardItems) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Set choreRewardItems */
  function setChoreRewardItems(uint256 choreId, uint256[] memory choreRewardItems) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 4, EncodeArray.encode((choreRewardItems)));
  }

  /** Set choreRewardItems (using the specified store) */
  function setChoreRewardItems(IStore _store, uint256 choreId, uint256[] memory choreRewardItems) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 4, EncodeArray.encode((choreRewardItems)));
  }

  /** Get the length of choreRewardItems */
  function lengthChoreRewardItems(uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 4, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of choreRewardItems (using the specified store) */
  function lengthChoreRewardItems(IStore _store, uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 4, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of choreRewardItems (unchecked, returns invalid data if index overflows) */
  function getItemChoreRewardItems(uint256 choreId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 4, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get an item of choreRewardItems (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemChoreRewardItems(IStore _store, uint256 choreId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 4, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Push an element to choreRewardItems */
  function pushChoreRewardItems(uint256 choreId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.pushToField(_tableId, _keyTuple, 4, abi.encodePacked((_element)));
  }

  /** Push an element to choreRewardItems (using the specified store) */
  function pushChoreRewardItems(IStore _store, uint256 choreId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.pushToField(_tableId, _keyTuple, 4, abi.encodePacked((_element)));
  }

  /** Pop an element from choreRewardItems */
  function popChoreRewardItems(uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.popFromField(_tableId, _keyTuple, 4, 32);
  }

  /** Pop an element from choreRewardItems (using the specified store) */
  function popChoreRewardItems(IStore _store, uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.popFromField(_tableId, _keyTuple, 4, 32);
  }

  /** Update an element of choreRewardItems at `_index` */
  function updateChoreRewardItems(uint256 choreId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.updateInField(_tableId, _keyTuple, 4, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of choreRewardItems (using the specified store) at `_index` */
  function updateChoreRewardItems(IStore _store, uint256 choreId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.updateInField(_tableId, _keyTuple, 4, _index * 32, abi.encodePacked((_element)));
  }

  /** Get choreRewardItemsNum */
  function getChoreRewardItemsNum(uint256 choreId) internal view returns (uint256[] memory choreRewardItemsNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 5);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Get choreRewardItemsNum (using the specified store) */
  function getChoreRewardItemsNum(
    IStore _store,
    uint256 choreId
  ) internal view returns (uint256[] memory choreRewardItemsNum) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 5);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /** Set choreRewardItemsNum */
  function setChoreRewardItemsNum(uint256 choreId, uint256[] memory choreRewardItemsNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 5, EncodeArray.encode((choreRewardItemsNum)));
  }

  /** Set choreRewardItemsNum (using the specified store) */
  function setChoreRewardItemsNum(IStore _store, uint256 choreId, uint256[] memory choreRewardItemsNum) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 5, EncodeArray.encode((choreRewardItemsNum)));
  }

  /** Get the length of choreRewardItemsNum */
  function lengthChoreRewardItemsNum(uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 5, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of choreRewardItemsNum (using the specified store) */
  function lengthChoreRewardItemsNum(IStore _store, uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 5, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of choreRewardItemsNum (unchecked, returns invalid data if index overflows) */
  function getItemChoreRewardItemsNum(uint256 choreId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 5, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get an item of choreRewardItemsNum (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemChoreRewardItemsNum(IStore _store, uint256 choreId, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 5, getSchema(), _index * 32, (_index + 1) * 32);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Push an element to choreRewardItemsNum */
  function pushChoreRewardItemsNum(uint256 choreId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.pushToField(_tableId, _keyTuple, 5, abi.encodePacked((_element)));
  }

  /** Push an element to choreRewardItemsNum (using the specified store) */
  function pushChoreRewardItemsNum(IStore _store, uint256 choreId, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.pushToField(_tableId, _keyTuple, 5, abi.encodePacked((_element)));
  }

  /** Pop an element from choreRewardItemsNum */
  function popChoreRewardItemsNum(uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.popFromField(_tableId, _keyTuple, 5, 32);
  }

  /** Pop an element from choreRewardItemsNum (using the specified store) */
  function popChoreRewardItemsNum(IStore _store, uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.popFromField(_tableId, _keyTuple, 5, 32);
  }

  /** Update an element of choreRewardItemsNum at `_index` */
  function updateChoreRewardItemsNum(uint256 choreId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.updateInField(_tableId, _keyTuple, 5, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of choreRewardItemsNum (using the specified store) at `_index` */
  function updateChoreRewardItemsNum(IStore _store, uint256 choreId, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.updateInField(_tableId, _keyTuple, 5, _index * 32, abi.encodePacked((_element)));
  }

  /** Get choreName */
  function getChoreName(uint256 choreId) internal view returns (string memory choreName) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 6);
    return (string(_blob));
  }

  /** Get choreName (using the specified store) */
  function getChoreName(IStore _store, uint256 choreId) internal view returns (string memory choreName) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 6);
    return (string(_blob));
  }

  /** Set choreName */
  function setChoreName(uint256 choreId, string memory choreName) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 6, bytes((choreName)));
  }

  /** Set choreName (using the specified store) */
  function setChoreName(IStore _store, uint256 choreId, string memory choreName) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 6, bytes((choreName)));
  }

  /** Get the length of choreName */
  function lengthChoreName(uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 6, getSchema());
    return _byteLength / 1;
  }

  /** Get the length of choreName (using the specified store) */
  function lengthChoreName(IStore _store, uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 6, getSchema());
    return _byteLength / 1;
  }

  /** Get an item of choreName (unchecked, returns invalid data if index overflows) */
  function getItemChoreName(uint256 choreId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 6, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Get an item of choreName (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemChoreName(IStore _store, uint256 choreId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 6, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Push a slice to choreName */
  function pushChoreName(uint256 choreId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.pushToField(_tableId, _keyTuple, 6, bytes((_slice)));
  }

  /** Push a slice to choreName (using the specified store) */
  function pushChoreName(IStore _store, uint256 choreId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.pushToField(_tableId, _keyTuple, 6, bytes((_slice)));
  }

  /** Pop a slice from choreName */
  function popChoreName(uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.popFromField(_tableId, _keyTuple, 6, 1);
  }

  /** Pop a slice from choreName (using the specified store) */
  function popChoreName(IStore _store, uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.popFromField(_tableId, _keyTuple, 6, 1);
  }

  /** Update a slice of choreName at `_index` */
  function updateChoreName(uint256 choreId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.updateInField(_tableId, _keyTuple, 6, _index * 1, bytes((_slice)));
  }

  /** Update a slice of choreName (using the specified store) at `_index` */
  function updateChoreName(IStore _store, uint256 choreId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.updateInField(_tableId, _keyTuple, 6, _index * 1, bytes((_slice)));
  }

  /** Get choreDescription */
  function getChoreDescription(uint256 choreId) internal view returns (string memory choreDescription) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 7);
    return (string(_blob));
  }

  /** Get choreDescription (using the specified store) */
  function getChoreDescription(IStore _store, uint256 choreId) internal view returns (string memory choreDescription) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 7);
    return (string(_blob));
  }

  /** Set choreDescription */
  function setChoreDescription(uint256 choreId, string memory choreDescription) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setField(_tableId, _keyTuple, 7, bytes((choreDescription)));
  }

  /** Set choreDescription (using the specified store) */
  function setChoreDescription(IStore _store, uint256 choreId, string memory choreDescription) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setField(_tableId, _keyTuple, 7, bytes((choreDescription)));
  }

  /** Get the length of choreDescription */
  function lengthChoreDescription(uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 7, getSchema());
    return _byteLength / 1;
  }

  /** Get the length of choreDescription (using the specified store) */
  function lengthChoreDescription(IStore _store, uint256 choreId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 7, getSchema());
    return _byteLength / 1;
  }

  /** Get an item of choreDescription (unchecked, returns invalid data if index overflows) */
  function getItemChoreDescription(uint256 choreId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 7, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Get an item of choreDescription (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemChoreDescription(
    IStore _store,
    uint256 choreId,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 7, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Push a slice to choreDescription */
  function pushChoreDescription(uint256 choreId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.pushToField(_tableId, _keyTuple, 7, bytes((_slice)));
  }

  /** Push a slice to choreDescription (using the specified store) */
  function pushChoreDescription(IStore _store, uint256 choreId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.pushToField(_tableId, _keyTuple, 7, bytes((_slice)));
  }

  /** Pop a slice from choreDescription */
  function popChoreDescription(uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.popFromField(_tableId, _keyTuple, 7, 1);
  }

  /** Pop a slice from choreDescription (using the specified store) */
  function popChoreDescription(IStore _store, uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.popFromField(_tableId, _keyTuple, 7, 1);
  }

  /** Update a slice of choreDescription at `_index` */
  function updateChoreDescription(uint256 choreId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.updateInField(_tableId, _keyTuple, 7, _index * 1, bytes((_slice)));
  }

  /** Update a slice of choreDescription (using the specified store) at `_index` */
  function updateChoreDescription(IStore _store, uint256 choreId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.updateInField(_tableId, _keyTuple, 7, _index * 1, bytes((_slice)));
  }

  /** Get the full data */
  function get(uint256 choreId) internal view returns (ChoresConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, uint256 choreId) internal view returns (ChoresConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    uint256 choreId,
    uint8 choreType,
    uint256 choreReward,
    uint8 choreRewardType,
    bytes32 choreRewardItemsHash,
    uint256[] memory choreRewardItems,
    uint256[] memory choreRewardItemsNum,
    string memory choreName,
    string memory choreDescription
  ) internal {
    bytes memory _data = encode(
      choreType,
      choreReward,
      choreRewardType,
      choreRewardItemsHash,
      choreRewardItems,
      choreRewardItemsNum,
      choreName,
      choreDescription
    );

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    uint256 choreId,
    uint8 choreType,
    uint256 choreReward,
    uint8 choreRewardType,
    bytes32 choreRewardItemsHash,
    uint256[] memory choreRewardItems,
    uint256[] memory choreRewardItemsNum,
    string memory choreName,
    string memory choreDescription
  ) internal {
    bytes memory _data = encode(
      choreType,
      choreReward,
      choreRewardType,
      choreRewardItemsHash,
      choreRewardItems,
      choreRewardItemsNum,
      choreName,
      choreDescription
    );

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(uint256 choreId, ChoresConfigData memory _table) internal {
    set(
      choreId,
      _table.choreType,
      _table.choreReward,
      _table.choreRewardType,
      _table.choreRewardItemsHash,
      _table.choreRewardItems,
      _table.choreRewardItemsNum,
      _table.choreName,
      _table.choreDescription
    );
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, uint256 choreId, ChoresConfigData memory _table) internal {
    set(
      _store,
      choreId,
      _table.choreType,
      _table.choreReward,
      _table.choreRewardType,
      _table.choreRewardItemsHash,
      _table.choreRewardItems,
      _table.choreRewardItemsNum,
      _table.choreName,
      _table.choreDescription
    );
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (ChoresConfigData memory _table) {
    // 66 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 66));

    _table.choreType = (uint8(Bytes.slice1(_blob, 0)));

    _table.choreReward = (uint256(Bytes.slice32(_blob, 1)));

    _table.choreRewardType = (uint8(Bytes.slice1(_blob, 33)));

    _table.choreRewardItemsHash = (Bytes.slice32(_blob, 34));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 66) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 98;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.choreRewardItems = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint256());

      _start = _end;
      _end += _encodedLengths.atIndex(1);
      _table.choreRewardItemsNum = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint256());

      _start = _end;
      _end += _encodedLengths.atIndex(2);
      _table.choreName = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

      _start = _end;
      _end += _encodedLengths.atIndex(3);
      _table.choreDescription = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint8 choreType,
    uint256 choreReward,
    uint8 choreRewardType,
    bytes32 choreRewardItemsHash,
    uint256[] memory choreRewardItems,
    uint256[] memory choreRewardItemsNum,
    string memory choreName,
    string memory choreDescription
  ) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](4);
    _counters[0] = uint40(choreRewardItems.length * 32);
    _counters[1] = uint40(choreRewardItemsNum.length * 32);
    _counters[2] = uint40(bytes(choreName).length);
    _counters[3] = uint40(bytes(choreDescription).length);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        choreType,
        choreReward,
        choreRewardType,
        choreRewardItemsHash,
        _encodedLengths.unwrap(),
        EncodeArray.encode((choreRewardItems)),
        EncodeArray.encode((choreRewardItemsNum)),
        bytes((choreName)),
        bytes((choreDescription))
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(uint256 choreId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));
  }

  /* Delete all data for given keys */
  function deleteRecord(uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, uint256 choreId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(choreId));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}