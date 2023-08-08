// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IWeightedSampleConfigSystem {
  function setSimpleSampleConfig(bytes32 sampleId, uint16[] memory indices) external;

  function addSimpleSampleConfig(bytes32 sampleId, uint16 index, uint8 weight) external;

  function setAliasSampleConfig(bytes32 sampleId, uint16[] memory rates, uint16[] memory indices) external;

  function addAliasSampleConfig(bytes32 sampleId, uint16 rate, uint16 index) external;

  function setPrefixSumSampleConfig(bytes32 sampleId, uint32[] memory accWeights) external;

  function addPrefixSumSampleConfig(bytes32 sampleId, uint32 accWeight) external;

  function getSampleIndex(bytes32 sampleId, uint256 randSeed, uint256 length) external view returns (uint256);

  function getSampleIndex(bytes32 sampleId, uint256 randSeed) external view returns (uint256);

  function getSimpleSampleIndex(bytes32 sampleId, uint16 randSeed) external view returns (uint16);

  function getAliasSampleIndex(bytes32 sampleId, uint256 randSeed) external view returns (uint16);

  function binarySearch(uint32[] memory arr, uint32 target) external pure returns (uint256);

  function getPrefixSumSampleIndex(bytes32 sampleId, uint256 randSeed) external view returns (uint256);
}
