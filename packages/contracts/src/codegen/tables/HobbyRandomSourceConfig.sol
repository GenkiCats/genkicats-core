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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("HobbyRandomSourc")));
bytes32 constant HobbyRandomSourceConfigTableId = _tableId;

struct HobbyRandomSourceConfigData {
  bool strictRandom;
  uint32 delayBlocks;
}

library HobbyRandomSourceConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.BOOL;
    _schema[1] = SchemaType.UINT32;

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
    _fieldNames[0] = "strictRandom";
    _fieldNames[1] = "delayBlocks";
    return ("HobbyRandomSourceConfig", _fieldNames);
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

  /** Get strictRandom */
  function getStrictRandom(bytes32 hobbyId) internal view returns (bool strictRandom) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Get strictRandom (using the specified store) */
  function getStrictRandom(IStore _store, bytes32 hobbyId) internal view returns (bool strictRandom) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Set strictRandom */
  function setStrictRandom(bytes32 hobbyId, bool strictRandom) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((strictRandom)));
  }

  /** Set strictRandom (using the specified store) */
  function setStrictRandom(IStore _store, bytes32 hobbyId, bool strictRandom) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((strictRandom)));
  }

  /** Get delayBlocks */
  function getDelayBlocks(bytes32 hobbyId) internal view returns (uint32 delayBlocks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get delayBlocks (using the specified store) */
  function getDelayBlocks(IStore _store, bytes32 hobbyId) internal view returns (uint32 delayBlocks) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set delayBlocks */
  function setDelayBlocks(bytes32 hobbyId, uint32 delayBlocks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((delayBlocks)));
  }

  /** Set delayBlocks (using the specified store) */
  function setDelayBlocks(IStore _store, bytes32 hobbyId, uint32 delayBlocks) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((delayBlocks)));
  }

  /** Get the full data */
  function get(bytes32 hobbyId) internal view returns (HobbyRandomSourceConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 hobbyId) internal view returns (HobbyRandomSourceConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 hobbyId, bool strictRandom, uint32 delayBlocks) internal {
    bytes memory _data = encode(strictRandom, delayBlocks);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 hobbyId, bool strictRandom, uint32 delayBlocks) internal {
    bytes memory _data = encode(strictRandom, delayBlocks);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 hobbyId, HobbyRandomSourceConfigData memory _table) internal {
    set(hobbyId, _table.strictRandom, _table.delayBlocks);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 hobbyId, HobbyRandomSourceConfigData memory _table) internal {
    set(_store, hobbyId, _table.strictRandom, _table.delayBlocks);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (HobbyRandomSourceConfigData memory _table) {
    _table.strictRandom = (_toBool(uint8(Bytes.slice1(_blob, 0))));

    _table.delayBlocks = (uint32(Bytes.slice4(_blob, 1)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bool strictRandom, uint32 delayBlocks) internal view returns (bytes memory) {
    return abi.encodePacked(strictRandom, delayBlocks);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 hobbyId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 hobbyId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 hobbyId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = hobbyId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}

function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
