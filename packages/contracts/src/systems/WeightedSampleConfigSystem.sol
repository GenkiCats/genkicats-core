// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";

import { SimpleSampleConfig, AliasSampleConfig, PrefixSumSampleConfig, SampleMethodConfig } from "../codegen/Tables.sol";

//TODO: this system is not public, only used by other systems, change the mud.config
contract WeightedSampleConfigSystem is System {
  uint16 constant PRECISION = 10000;

  //TODO: add partial config set

  function setSimpleSampleConfig(bytes32 sampleId, uint16[] memory indices) public {
    require(indices.length <= 65535, "indices length too large");
    SimpleSampleConfig.set(sampleId, indices);
  }

  function addSimpleSampleConfig(bytes32 sampleId, uint16 index, uint8 weight) public {
    for (uint8 i = 0; i < weight; i++) {
      SimpleSampleConfig.push(sampleId, index);
    }
  }

  function setAliasSampleConfig(bytes32 sampleId, uint16[] memory rates, uint16[] memory indices) public {
    require(rates.length == indices.length, "rates and indices length not match");
    require(rates.length <= 65535, "rates and indices length too large");
    AliasSampleConfig.set(sampleId, rates, indices);
  }

  function addAliasSampleConfig(bytes32 sampleId, uint16 rate, uint16 index) public {
    AliasSampleConfig.pushRates(sampleId, rate);
    AliasSampleConfig.pushIndices(sampleId, index);
  }

  // Must ensure the last accWeights is the total weight
  // Must also ensure the total weight is less than 2^32
  function setPrefixSumSampleConfig(bytes32 sampleId, uint32[] memory accWeights) public {
    PrefixSumSampleConfig.set(sampleId, accWeights);
  }

  function addPrefixSumSampleConfig(bytes32 sampleId, uint32 accWeight) public {
    PrefixSumSampleConfig.push(sampleId, accWeight);
  }

  function getSampleIndex(bytes32 sampleId, uint256 randSeed, uint256 length) public view returns (uint256) {
    uint8 method = SampleMethodConfig.get(sampleId);
    if (method == 0) {
      return randSeed % length;
    } else {
      return getSampleIndex(sampleId, randSeed);
    }
  }

  function getSampleIndex(bytes32 sampleId, uint256 randSeed) public view returns (uint256) {
    uint8 method = SampleMethodConfig.get(sampleId);
    if (method == 0) {
      revert("must provide length when use no weight sample method");
    } else if (method == 1) {
      return uint256(getSimpleSampleIndex(sampleId, uint16(randSeed)));
    } else if (method == 2) {
      return uint256(getAliasSampleIndex(sampleId, randSeed));
    } else if (method == 3) {
      return getPrefixSumSampleIndex(sampleId, randSeed);
    } else {
      revert("invalid sample method");
    }
  }

  function getSimpleSampleIndex(bytes32 sampleId, uint16 randSeed) public view returns (uint16) {
    uint16[] memory indices = SimpleSampleConfig.get(sampleId);
    uint16 index = indices[randSeed % indices.length];
    return index;
  }

  function getAliasSampleIndex(bytes32 sampleId, uint256 randSeed) public view returns (uint16) {
    uint16[] memory rates = AliasSampleConfig.getRates(sampleId);
    uint16[] memory indices = AliasSampleConfig.getIndices(sampleId);
    uint16 randIndex = uint16(randSeed % indices.length);

    uint16 rate = rates[randIndex];
    uint16 index = indices[randIndex];
    if (uint16(randSeed % PRECISION) < rate) {
      return randIndex;
    } else {
      return index;
    }
  }

  function binarySearch(uint32[] memory arr, uint32 target) public pure returns (uint256) {
    uint256 left = 0;
    uint256 right = arr.length - 1;
    while (left < right) {
      uint256 mid = (left + right) / 2;
      if (arr[mid] < target) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    return left;
  }

  function getPrefixSumSampleIndex(bytes32 sampleId, uint256 randSeed) public view returns (uint256) {
    uint32[] memory accWeights = PrefixSumSampleConfig.get(sampleId);
    uint32 totalWeight = accWeights[accWeights.length - 1];
    uint32 randWeight = uint32(randSeed % totalWeight);
    uint256 index = binarySearch(accWeights, randWeight);
    return index;
  }
}
