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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("UserStatus")));
bytes32 constant UserStatusTableId = _tableId;

struct UserStatusData {
  uint256 coinBalance;
  uint256 diamondBalance;
  uint32 level;
  uint32 exp;
  bool timeZoneSign;
  uint32 timeZoneOffset;
  string nickName;
}

library UserStatus {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](7);
    _schema[0] = SchemaType.UINT256;
    _schema[1] = SchemaType.UINT256;
    _schema[2] = SchemaType.UINT32;
    _schema[3] = SchemaType.UINT32;
    _schema[4] = SchemaType.BOOL;
    _schema[5] = SchemaType.UINT32;
    _schema[6] = SchemaType.STRING;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](7);
    _fieldNames[0] = "coinBalance";
    _fieldNames[1] = "diamondBalance";
    _fieldNames[2] = "level";
    _fieldNames[3] = "exp";
    _fieldNames[4] = "timeZoneSign";
    _fieldNames[5] = "timeZoneOffset";
    _fieldNames[6] = "nickName";
    return ("UserStatus", _fieldNames);
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

  /** Get coinBalance */
  function getCoinBalance(bytes32 userId) internal view returns (uint256 coinBalance) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get coinBalance (using the specified store) */
  function getCoinBalance(IStore _store, bytes32 userId) internal view returns (uint256 coinBalance) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set coinBalance */
  function setCoinBalance(bytes32 userId, uint256 coinBalance) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((coinBalance)));
  }

  /** Set coinBalance (using the specified store) */
  function setCoinBalance(IStore _store, bytes32 userId, uint256 coinBalance) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((coinBalance)));
  }

  /** Get diamondBalance */
  function getDiamondBalance(bytes32 userId) internal view returns (uint256 diamondBalance) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Get diamondBalance (using the specified store) */
  function getDiamondBalance(IStore _store, bytes32 userId) internal view returns (uint256 diamondBalance) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (uint256(Bytes.slice32(_blob, 0)));
  }

  /** Set diamondBalance */
  function setDiamondBalance(bytes32 userId, uint256 diamondBalance) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((diamondBalance)));
  }

  /** Set diamondBalance (using the specified store) */
  function setDiamondBalance(IStore _store, bytes32 userId, uint256 diamondBalance) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((diamondBalance)));
  }

  /** Get level */
  function getLevel(bytes32 userId) internal view returns (uint32 level) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get level (using the specified store) */
  function getLevel(IStore _store, bytes32 userId) internal view returns (uint32 level) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 2);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set level */
  function setLevel(bytes32 userId, uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 2, abi.encodePacked((level)));
  }

  /** Set level (using the specified store) */
  function setLevel(IStore _store, bytes32 userId, uint32 level) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 2, abi.encodePacked((level)));
  }

  /** Get exp */
  function getExp(bytes32 userId) internal view returns (uint32 exp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get exp (using the specified store) */
  function getExp(IStore _store, bytes32 userId) internal view returns (uint32 exp) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 3);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set exp */
  function setExp(bytes32 userId, uint32 exp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 3, abi.encodePacked((exp)));
  }

  /** Set exp (using the specified store) */
  function setExp(IStore _store, bytes32 userId, uint32 exp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 3, abi.encodePacked((exp)));
  }

  /** Get timeZoneSign */
  function getTimeZoneSign(bytes32 userId) internal view returns (bool timeZoneSign) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 4);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Get timeZoneSign (using the specified store) */
  function getTimeZoneSign(IStore _store, bytes32 userId) internal view returns (bool timeZoneSign) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 4);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Set timeZoneSign */
  function setTimeZoneSign(bytes32 userId, bool timeZoneSign) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 4, abi.encodePacked((timeZoneSign)));
  }

  /** Set timeZoneSign (using the specified store) */
  function setTimeZoneSign(IStore _store, bytes32 userId, bool timeZoneSign) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 4, abi.encodePacked((timeZoneSign)));
  }

  /** Get timeZoneOffset */
  function getTimeZoneOffset(bytes32 userId) internal view returns (uint32 timeZoneOffset) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get timeZoneOffset (using the specified store) */
  function getTimeZoneOffset(IStore _store, bytes32 userId) internal view returns (uint32 timeZoneOffset) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 5);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set timeZoneOffset */
  function setTimeZoneOffset(bytes32 userId, uint32 timeZoneOffset) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 5, abi.encodePacked((timeZoneOffset)));
  }

  /** Set timeZoneOffset (using the specified store) */
  function setTimeZoneOffset(IStore _store, bytes32 userId, uint32 timeZoneOffset) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 5, abi.encodePacked((timeZoneOffset)));
  }

  /** Get nickName */
  function getNickName(bytes32 userId) internal view returns (string memory nickName) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 6);
    return (string(_blob));
  }

  /** Get nickName (using the specified store) */
  function getNickName(IStore _store, bytes32 userId) internal view returns (string memory nickName) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 6);
    return (string(_blob));
  }

  /** Set nickName */
  function setNickName(bytes32 userId, string memory nickName) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setField(_tableId, _keyTuple, 6, bytes((nickName)));
  }

  /** Set nickName (using the specified store) */
  function setNickName(IStore _store, bytes32 userId, string memory nickName) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setField(_tableId, _keyTuple, 6, bytes((nickName)));
  }

  /** Get the length of nickName */
  function lengthNickName(bytes32 userId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 6, getSchema());
    return _byteLength / 1;
  }

  /** Get the length of nickName (using the specified store) */
  function lengthNickName(IStore _store, bytes32 userId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 6, getSchema());
    return _byteLength / 1;
  }

  /** Get an item of nickName (unchecked, returns invalid data if index overflows) */
  function getItemNickName(bytes32 userId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 6, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Get an item of nickName (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItemNickName(IStore _store, bytes32 userId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 6, getSchema(), _index * 1, (_index + 1) * 1);
    return (string(_blob));
  }

  /** Push a slice to nickName */
  function pushNickName(bytes32 userId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.pushToField(_tableId, _keyTuple, 6, bytes((_slice)));
  }

  /** Push a slice to nickName (using the specified store) */
  function pushNickName(IStore _store, bytes32 userId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.pushToField(_tableId, _keyTuple, 6, bytes((_slice)));
  }

  /** Pop a slice from nickName */
  function popNickName(bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.popFromField(_tableId, _keyTuple, 6, 1);
  }

  /** Pop a slice from nickName (using the specified store) */
  function popNickName(IStore _store, bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.popFromField(_tableId, _keyTuple, 6, 1);
  }

  /** Update a slice of nickName at `_index` */
  function updateNickName(bytes32 userId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.updateInField(_tableId, _keyTuple, 6, _index * 1, bytes((_slice)));
  }

  /** Update a slice of nickName (using the specified store) at `_index` */
  function updateNickName(IStore _store, bytes32 userId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.updateInField(_tableId, _keyTuple, 6, _index * 1, bytes((_slice)));
  }

  /** Get the full data */
  function get(bytes32 userId) internal view returns (UserStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 userId) internal view returns (UserStatusData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(
    bytes32 userId,
    uint256 coinBalance,
    uint256 diamondBalance,
    uint32 level,
    uint32 exp,
    bool timeZoneSign,
    uint32 timeZoneOffset,
    string memory nickName
  ) internal {
    bytes memory _data = encode(coinBalance, diamondBalance, level, exp, timeZoneSign, timeZoneOffset, nickName);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(
    IStore _store,
    bytes32 userId,
    uint256 coinBalance,
    uint256 diamondBalance,
    uint32 level,
    uint32 exp,
    bool timeZoneSign,
    uint32 timeZoneOffset,
    string memory nickName
  ) internal {
    bytes memory _data = encode(coinBalance, diamondBalance, level, exp, timeZoneSign, timeZoneOffset, nickName);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 userId, UserStatusData memory _table) internal {
    set(
      userId,
      _table.coinBalance,
      _table.diamondBalance,
      _table.level,
      _table.exp,
      _table.timeZoneSign,
      _table.timeZoneOffset,
      _table.nickName
    );
  }

  /** Set the full data using the data struct (using the specified store) */
  function set(IStore _store, bytes32 userId, UserStatusData memory _table) internal {
    set(
      _store,
      userId,
      _table.coinBalance,
      _table.diamondBalance,
      _table.level,
      _table.exp,
      _table.timeZoneSign,
      _table.timeZoneOffset,
      _table.nickName
    );
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (UserStatusData memory _table) {
    // 77 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 77));

    _table.coinBalance = (uint256(Bytes.slice32(_blob, 0)));

    _table.diamondBalance = (uint256(Bytes.slice32(_blob, 32)));

    _table.level = (uint32(Bytes.slice4(_blob, 64)));

    _table.exp = (uint32(Bytes.slice4(_blob, 68)));

    _table.timeZoneSign = (_toBool(uint8(Bytes.slice1(_blob, 72))));

    _table.timeZoneOffset = (uint32(Bytes.slice4(_blob, 73)));

    // Store trims the blob if dynamic fields are all empty
    if (_blob.length > 77) {
      uint256 _start;
      // skip static data length + dynamic lengths word
      uint256 _end = 109;

      _start = _end;
      _end += _encodedLengths.atIndex(0);
      _table.nickName = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
    }
  }

  /** Tightly pack full data using this table's schema */
  function encode(
    uint256 coinBalance,
    uint256 diamondBalance,
    uint32 level,
    uint32 exp,
    bool timeZoneSign,
    uint32 timeZoneOffset,
    string memory nickName
  ) internal pure returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(bytes(nickName).length);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return
      abi.encodePacked(
        coinBalance,
        diamondBalance,
        level,
        exp,
        timeZoneSign,
        timeZoneOffset,
        _encodedLengths.unwrap(),
        bytes((nickName))
      );
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 userId) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 userId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = userId;

    _store.deleteRecord(_tableId, _keyTuple);
  }
}

function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
