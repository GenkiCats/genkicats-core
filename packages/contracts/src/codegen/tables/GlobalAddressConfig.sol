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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("GlobalAddressCon")));
bytes32 constant GlobalAddressConfigTableId = _tableId;

library GlobalAddressConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.ADDRESS;

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
    _fieldNames[0] = "configValue";
    return ("GlobalAddressConfig", _fieldNames);
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

  /** Get configValue */
  function get(bytes32 configKey) internal view returns (address configValue) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (address(Bytes.slice20(_blob, 0)));
  }

  /** Get configValue (using the specified store) */
  function get(IStore _store, bytes32 configKey) internal view returns (address configValue) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (address(Bytes.slice20(_blob, 0)));
  }

  /** Set configValue */
  function set(bytes32 configKey, address configValue) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((configValue)));
  }

  /** Set configValue (using the specified store) */
  function set(IStore _store, bytes32 configKey, address configValue) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((configValue)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(address configValue) internal pure returns (bytes memory) {
    return abi.encodePacked(configValue);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 configKey) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 configKey) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 configKey) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = configKey;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
