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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("HobbyBasicConfig")));
bytes32 constant HobbyBasicConfigTableId = _tableId;

struct HobbyBasicConfigData {
  uint32 hungerCatExpRate;
  uint32 hungerUserExpRate;
}

library HobbyBasicConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](0);

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "hungerCatExpRate";
    _fieldNames[1] = "hungerUserExpRate";
    return ("HobbyBasicConfig", _fieldNames);
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

  /** Get hungerCatExpRate */
  function getHungerCatExpRate() internal view returns (uint32 hungerCatExpRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get hungerCatExpRate (using the specified store) */
  function getHungerCatExpRate(IStore _store) internal view returns (uint32 hungerCatExpRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set hungerCatExpRate */
  function setHungerCatExpRate(uint32 hungerCatExpRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((hungerCatExpRate)));
  }

  /** Set hungerCatExpRate (using the specified store) */
  function setHungerCatExpRate(IStore _store, uint32 hungerCatExpRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((hungerCatExpRate)));
  }

  /** Get hungerUserExpRate */
  function getHungerUserExpRate() internal view returns (uint32 hungerUserExpRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get hungerUserExpRate (using the specified store) */
  function getHungerUserExpRate(IStore _store) internal view returns (uint32 hungerUserExpRate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set hungerUserExpRate */
  function setHungerUserExpRate(uint32 hungerUserExpRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((hungerUserExpRate)));
  }

  /** Set hungerUserExpRate (using the specified store) */
  function setHungerUserExpRate(IStore _store, uint32 hungerUserExpRate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((hungerUserExpRate)));
  }

  /** Get the full data */
  function get() internal view returns (HobbyBasicConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store) internal view returns (HobbyBasicConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(uint32 hungerCatExpRate, uint32 hungerUserExpRate) internal {
    bytes memory _data = encode(hungerCatExpRate, hungerUserExpRate);

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, uint32 hungerCatExpRate, uint32 hungerUserExpRate) internal {
    bytes memory _data = encode(hungerCatExpRate, hungerUserExpRate);

    bytes32[] memory _keyTuple = new bytes32[](0);

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(HobbyBasicConfigData memory _table) internal {
    set(_table.hungerCatExpRate, _table.hungerUserExpRate);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, HobbyBasicConfigData memory _table) internal {
    set(_store, _table.hungerCatExpRate, _table.hungerUserExpRate);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (HobbyBasicConfigData memory _table) {
    _table.hungerCatExpRate = (uint32(Bytes.slice4(_blob, 0)));

    _table.hungerUserExpRate = (uint32(Bytes.slice4(_blob, 4)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint32 hungerCatExpRate, uint32 hungerUserExpRate) internal pure returns (bytes memory) {
    return abi.encodePacked(hungerCatExpRate, hungerUserExpRate);
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
