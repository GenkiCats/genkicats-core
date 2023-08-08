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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("AutoFeederLevelC")));
bytes32 constant AutoFeederLevelConfigTableId = _tableId;

struct AutoFeederLevelConfigData {
  uint32 foodLimit;
  uint32 foodPrice;
}

library AutoFeederLevelConfig {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "foodLimit";
    _fieldNames[1] = "foodPrice";
    return ("AutoFeederLevelConfig", _fieldNames);
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

  /** Get foodLimit */
  function getFoodLimit(uint32 level) internal view returns (uint32 foodLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get foodLimit (using the specified store) */
  function getFoodLimit(IStore _store, uint32 level) internal view returns (uint32 foodLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set foodLimit */
  function setFoodLimit(uint32 level, uint32 foodLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((foodLimit)));
  }

  /** Set foodLimit (using the specified store) */
  function setFoodLimit(IStore _store, uint32 level, uint32 foodLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((foodLimit)));
  }

  /** Get foodPrice */
  function getFoodPrice(uint32 level) internal view returns (uint32 foodPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get foodPrice (using the specified store) */
  function getFoodPrice(IStore _store, uint32 level) internal view returns (uint32 foodPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set foodPrice */
  function setFoodPrice(uint32 level, uint32 foodPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((foodPrice)));
  }

  /** Set foodPrice (using the specified store) */
  function setFoodPrice(IStore _store, uint32 level, uint32 foodPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((foodPrice)));
  }

  /** Get the full data */
  function get(uint32 level) internal view returns (AutoFeederLevelConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, uint32 level) internal view returns (AutoFeederLevelConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(uint32 level, uint32 foodLimit, uint32 foodPrice) internal {
    bytes memory _data = encode(foodLimit, foodPrice);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, uint32 level, uint32 foodLimit, uint32 foodPrice) internal {
    bytes memory _data = encode(foodLimit, foodPrice);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(uint32 level, AutoFeederLevelConfigData memory _table) internal {
    set(level, _table.foodLimit, _table.foodPrice);
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, uint32 level, AutoFeederLevelConfigData memory _table) internal {
    set(_store, level, _table.foodLimit, _table.foodPrice);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (AutoFeederLevelConfigData memory _table) {
    _table.foodLimit = (uint32(Bytes.slice4(_blob, 0)));

    _table.foodPrice = (uint32(Bytes.slice4(_blob, 4)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint32 foodLimit, uint32 foodPrice) internal view returns (bytes memory) {
    return abi.encodePacked(foodLimit, foodPrice);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(uint32 level) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));
  }

  /* Delete all data for given keys */
  function deleteRecord(uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(level));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
