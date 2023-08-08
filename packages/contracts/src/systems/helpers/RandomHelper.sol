// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

function getSimpleRandomInt(uint256 maxValue) view returns (uint256) {
  uint256 randomSeed = uint256(
    keccak256(abi.encodePacked(block.timestamp, block.number, blockhash(block.number - 1), msg.sender))
  );
  return randomSeed % maxValue;
}

function getSimpleRandomBool() view returns (bool) {
  uint256 randomSeed = uint256(
    keccak256(abi.encodePacked(block.timestamp, block.number, blockhash(block.number - 1), msg.sender))
  );
  if (randomSeed % 2 == 0) {
    return true;
  } else {
    return false;
  }
}
