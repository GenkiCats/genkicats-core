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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Shop")));
bytes32 constant ShopTableId = _tableId;

struct ShopData {
  uint256 itemCoinPrice;
  uint256 itemDiamondPrice;
  uint256 itemTokenPrice;
  uint32 itemUnlockLevel;
  uint32 itemDailyLimit;
  uint32 itemWeeklyLimit;
  uint32 itemMonthlyLimit;
  uint32 itemForeverLimit;
}

library Shop {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](8);
    _schema[0] = SchemaType.UINT256;
    _schema[1] = SchemaType.UINT256;
    _schema[2] = SchemaType.UINT256;
    _schema[3] = SchemaType.UINT32;
    _schema[4] = SchemaType.UINT32;
    _schema[5] = SchemaType.UINT32;
    _schema[6] = SchemaType.UINT32;
    _schema[7] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](8);
    _fieldNames[0] = "itemCoinPrice";
    _fieldNames[1] = "itemDiamondPrice";
    _fieldNames[2] = "itemTokenPrice";
    _fieldNames[3] = "itemUnlockLevel";
    _fieldNames[4] = "itemDailyLimit";
    _fieldNames[5] = "itemWeeklyLimit";
    _fieldNames[6] = "itemMonthlyLimit";
    _fieldNames[7] = "itemForeverLimit";
    return ("Shop", _fieldNames);
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

  /** Get itemCoinPrice */
  function getItemCoinPrice(bytes32 itemId) internal view returns (uint256 itemCoinPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get itemCoinPrice (using the specified store) */
  function getItemCoinPrice(IStore _store, bytes32 itemId) internal view returns (uint256 itemCoinPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set itemCoinPrice */
  function setItemCoinPrice(bytes32 itemId, uint256 itemCoinPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemCoinPrice)));
  }

  /** Set itemCoinPrice (using the specified store) */
  function setItemCoinPrice(IStore _store, bytes32 itemId, uint256 itemCoinPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((itemCoinPrice)));
  }

  /** Get itemDiamondPrice */
  function getItemDiamondPrice(bytes32 itemId) internal view returns (uint256 itemDiamondPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get itemDiamondPrice (using the specified store) */
  function getItemDiamondPrice(IStore _store, bytes32 itemId) internal view returns (uint256 itemDiamondPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set itemDiamondPrice */
  function setItemDiamondPrice(bytes32 itemId, uint256 itemDiamondPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemDiamondPrice)));
  }

  /** Set itemDiamondPrice (using the specified store) */
  function setItemDiamondPrice(IStore _store, bytes32 itemId, uint256 itemDiamondPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((itemDiamondPrice)));
  }

  /** Get itemTokenPrice */
  function getItemTokenPrice(bytes32 itemId) internal view returns (uint256 itemTokenPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get itemTokenPrice (using the specified store) */
  function getItemTokenPrice(IStore _store, bytes32 itemId) internal view returns (uint256 itemTokenPrice) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set itemTokenPrice */
  function setItemTokenPrice(bytes32 itemId, uint256 itemTokenPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((itemTokenPrice)));
  }

  /** Set itemTokenPrice (using the specified store) */
  function setItemTokenPrice(IStore _store, bytes32 itemId, uint256 itemTokenPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((itemTokenPrice)));
  }

  /** Get itemUnlockLevel */
  function getItemUnlockLevel(bytes32 itemId) internal view returns (uint32 itemUnlockLevel) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemUnlockLevel (using the specified store) */
  function getItemUnlockLevel(IStore _store, bytes32 itemId) internal view returns (uint32 itemUnlockLevel) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemUnlockLevel */
  function setItemUnlockLevel(bytes32 itemId, uint32 itemUnlockLevel) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((itemUnlockLevel)));
  }

  /** Set itemUnlockLevel (using the specified store) */
  function setItemUnlockLevel(IStore _store, bytes32 itemId, uint32 itemUnlockLevel) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((itemUnlockLevel)));
  }

  /** Get itemDailyLimit */
  function getItemDailyLimit(bytes32 itemId) internal view returns (uint32 itemDailyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemDailyLimit (using the specified store) */
  function getItemDailyLimit(IStore _store, bytes32 itemId) internal view returns (uint32 itemDailyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemDailyLimit */
  function setItemDailyLimit(bytes32 itemId, uint32 itemDailyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 4, abi.encodePacked((itemDailyLimit)));
  }

  /** Set itemDailyLimit (using the specified store) */
  function setItemDailyLimit(IStore _store, bytes32 itemId, uint32 itemDailyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 4, abi.encodePacked((itemDailyLimit)));
  }

  /** Get itemWeeklyLimit */
  function getItemWeeklyLimit(bytes32 itemId) internal view returns (uint32 itemWeeklyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemWeeklyLimit (using the specified store) */
  function getItemWeeklyLimit(IStore _store, bytes32 itemId) internal view returns (uint32 itemWeeklyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemWeeklyLimit */
  function setItemWeeklyLimit(bytes32 itemId, uint32 itemWeeklyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 5, abi.encodePacked((itemWeeklyLimit)));
  }

  /** Set itemWeeklyLimit (using the specified store) */
  function setItemWeeklyLimit(IStore _store, bytes32 itemId, uint32 itemWeeklyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 5, abi.encodePacked((itemWeeklyLimit)));
  }

  /** Get itemMonthlyLimit */
  function getItemMonthlyLimit(bytes32 itemId) internal view returns (uint32 itemMonthlyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 6);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemMonthlyLimit (using the specified store) */
  function getItemMonthlyLimit(IStore _store, bytes32 itemId) internal view returns (uint32 itemMonthlyLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 6);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemMonthlyLimit */
  function setItemMonthlyLimit(bytes32 itemId, uint32 itemMonthlyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 6, abi.encodePacked((itemMonthlyLimit)));
  }

  /** Set itemMonthlyLimit (using the specified store) */
  function setItemMonthlyLimit(IStore _store, bytes32 itemId, uint32 itemMonthlyLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 6, abi.encodePacked((itemMonthlyLimit)));
  }

  /** Get itemForeverLimit */
  function getItemForeverLimit(bytes32 itemId) internal view returns (uint32 itemForeverLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 7);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get itemForeverLimit (using the specified store) */
  function getItemForeverLimit(IStore _store, bytes32 itemId) internal view returns (uint32 itemForeverLimit) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 7);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set itemForeverLimit */
  function setItemForeverLimit(bytes32 itemId, uint32 itemForeverLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setField(_tableId, _keyTuple, 7, abi.encodePacked((itemForeverLimit)));
  }

  /** Set itemForeverLimit (using the specified store) */
  function setItemForeverLimit(IStore _store, bytes32 itemId, uint32 itemForeverLimit) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setField(_tableId, _keyTuple, 7, abi.encodePacked((itemForeverLimit)));
  }

  /** Get the full data */
  function get(bytes32 itemId) internal view returns (ShopData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 itemId) internal view returns (ShopData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 itemId,
    uint256 itemCoinPrice,
    uint256 itemDiamondPrice,
    uint256 itemTokenPrice,
    uint32 itemUnlockLevel,
    uint32 itemDailyLimit,
    uint32 itemWeeklyLimit,
    uint32 itemMonthlyLimit,
    uint32 itemForeverLimit
  ) internal {
    bytes memory _data = encode(
      itemCoinPrice,
      itemDiamondPrice,
      itemTokenPrice,
      itemUnlockLevel,
      itemDailyLimit,
      itemWeeklyLimit,
      itemMonthlyLimit,
      itemForeverLimit
    );

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 itemId,
    uint256 itemCoinPrice,
    uint256 itemDiamondPrice,
    uint256 itemTokenPrice,
    uint32 itemUnlockLevel,
    uint32 itemDailyLimit,
    uint32 itemWeeklyLimit,
    uint32 itemMonthlyLimit,
    uint32 itemForeverLimit
  ) internal {
    bytes memory _data = encode(
      itemCoinPrice,
      itemDiamondPrice,
      itemTokenPrice,
      itemUnlockLevel,
      itemDailyLimit,
      itemWeeklyLimit,
      itemMonthlyLimit,
      itemForeverLimit
    );

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 itemId, ShopData memory _table) internal {
    set(
      itemId,
      _table.itemCoinPrice,
      _table.itemDiamondPrice,
      _table.itemTokenPrice,
      _table.itemUnlockLevel,
      _table.itemDailyLimit,
      _table.itemWeeklyLimit,
      _table.itemMonthlyLimit,
      _table.itemForeverLimit
    );
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 itemId, ShopData memory _table) internal {
    set(
      _store,
      itemId,
      _table.itemCoinPrice,
      _table.itemDiamondPrice,
      _table.itemTokenPrice,
      _table.itemUnlockLevel,
      _table.itemDailyLimit,
      _table.itemWeeklyLimit,
      _table.itemMonthlyLimit,
      _table.itemForeverLimit
    );
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (ShopData memory _table) {
    _table.itemCoinPrice = (uint256(Bytes.slice32(_blob, 0)));

    _table.itemDiamondPrice = (uint256(Bytes.slice32(_blob, 32)));

    _table.itemTokenPrice = (uint256(Bytes.slice32(_blob, 64)));

    _table.itemUnlockLevel = (uint32(Bytes.slice4(_blob, 96)));

    _table.itemDailyLimit = (uint32(Bytes.slice4(_blob, 100)));

    _table.itemWeeklyLimit = (uint32(Bytes.slice4(_blob, 104)));

    _table.itemMonthlyLimit = (uint32(Bytes.slice4(_blob, 108)));

    _table.itemForeverLimit = (uint32(Bytes.slice4(_blob, 112)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint256 itemCoinPrice,
    uint256 itemDiamondPrice,
    uint256 itemTokenPrice,
    uint32 itemUnlockLevel,
    uint32 itemDailyLimit,
    uint32 itemWeeklyLimit,
    uint32 itemMonthlyLimit,
    uint32 itemForeverLimit
  ) internal view returns (bytes memory) {
    return
      abi.encodePacked(
        itemCoinPrice,
        itemDiamondPrice,
        itemTokenPrice,
        itemUnlockLevel,
        itemDailyLimit,
        itemWeeklyLimit,
        itemMonthlyLimit,
        itemForeverLimit
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 itemId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 itemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = itemId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
