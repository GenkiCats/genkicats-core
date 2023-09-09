// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";

import { SimpleSampleConfig, AliasSampleConfig, PrefixSumSampleConfig, SampleMethodConfig } from "../codegen/Tables.sol";

import { LibSample } from "./libs/LibSample.sol";

contract SampleOpenConfigSystem is System {
  // general function to set sample config
  function setSampleConfig(
    bytes32 sampleId,
    uint8 method,
    uint16[] memory indices,
    uint16[] memory rates,
    uint32[] memory accWeights
  ) public {
    address designer = SampleMethodConfig.getDesigner(sampleId);
    require(designer == _msgSender() || designer == address(0), "only designer can change owner");
    SampleMethodConfig.setDesigner(sampleId, _msgSender());

    SampleMethodConfig.setSamplingMethod(sampleId, method);
    if (method == 0) {
      // do nothing
      return;
    } else if (method == 1) {
      LibSample.setSimpleSampleConfig(sampleId, indices);
    } else if (method == 2) {
      LibSample.setAliasSampleConfig(sampleId, rates, indices);
    } else if (method == 3) {
      LibSample.setPrefixSumSampleConfig(sampleId, accWeights);
    } else {
      revert("invalid sample method");
    }
  }

  function addSampleConfig(
    bytes32 sampleId,
    uint8 method,
    uint16 index,
    uint8 weight,
    uint16 rate,
    uint32 accWeight
  ) public {
    SampleMethodConfig.setSamplingMethod(sampleId, method);
    if (method == 0) {
      // do nothing
      return;
    } else if (method == 1) {
      LibSample.addSimpleSampleConfig(sampleId, index, weight);
    } else if (method == 2) {
      LibSample.addAliasSampleConfig(sampleId, rate, index);
    } else if (method == 3) {
      LibSample.addPrefixSumSampleConfig(sampleId, accWeight);
    } else {
      revert("invalid sample method");
    }
  }

  function changeSampleConfigDesigner(bytes32 sampleId, address newDesigner) public {
    address designer = SampleMethodConfig.getDesigner(sampleId);
    require(designer == _msgSender(), "only designer can change owner");
    SampleMethodConfig.setDesigner(sampleId, newDesigner);
  }

  function getSampleIndex(
    bytes32 sampleId,
    uint256 randSeed,
    string memory salt,
    uint256 length
  ) public view returns (uint256) {
    uint8 method = SampleMethodConfig.getSamplingMethod(sampleId);
    if (method == 0) {
      require(length > 0, "must provide valid length when use no weight sample method");
      return randSeed % length;
    } else {
      randSeed = uint256(keccak256(abi.encodePacked(salt, randSeed)));
      return getSampleIndex(sampleId, randSeed);
    }
  }

  function getSampleIndex(bytes32 sampleId, uint256 randSeed, uint256 length) public view returns (uint256) {
    uint8 method = SampleMethodConfig.getSamplingMethod(sampleId);
    if (method == 0) {
      require(length > 0, "must provide valid length when use no weight sample method");
      return randSeed % length;
    } else {
      return getSampleIndex(sampleId, randSeed);
    }
  }

  function getSampleIndex(bytes32 sampleId, uint256 randSeed) public view returns (uint256) {
    uint8 method = SampleMethodConfig.getSamplingMethod(sampleId);
    if (method == 0) {
      revert("must provide length when use no weight sample method");
    } else if (method == 1) {
      return uint256(LibSample.getSimpleSampleIndex(sampleId, uint16(randSeed)));
    } else if (method == 2) {
      return uint256(LibSample.getAliasSampleIndex(sampleId, randSeed));
    } else if (method == 3) {
      return LibSample.getPrefixSumSampleIndex(sampleId, randSeed);
    } else {
      revert("invalid sample method");
    }
  }

  /**
   *
   * Get multiple sample indices based on Fisher-Yates shuffle algorithm
   *
   * @param sampleId The sample id
   * @param randSeed The random seed
   * @param salt The salt
   * @param sampleCount The number of samples to take
   * @param totalCount The total number of elements to sample from
   */
  function getSampleIndices(
    bytes32 sampleId,
    uint256 randSeed,
    string memory salt,
    uint256 sampleCount,
    uint256 totalCount
  ) public view returns (uint256[] memory) {
    require(sampleCount <= totalCount, "sample count must be less than total count");
    uint8 method = SampleMethodConfig.getSamplingMethod(sampleId);

    uint256[] memory sampleIndices = new uint256[](sampleCount);
    uint256[] memory indicesArray = new uint256[](totalCount);
    uint256 indicesArrayCount = sampleCount;

    // Initialize the indicesArray with the indices
    for (uint256 i = 0; i < totalCount; i++) {
      indicesArray[i] = i;
    }

    // Perform n sampling iterations
    for (uint256 i = 0; i < sampleCount; i++) {
      // Generate a random index within the remaining elements of the indices array
      uint256 randomIndex = getSampleIndex(sampleId, randSeed, salt, indicesArrayCount);

      // Take a sample index from the indices array
      sampleIndices[i] = indicesArray[randomIndex];

      // Swap the sampled index with the last index in the indices array
      indicesArray[randomIndex] = indicesArray[indicesArrayCount - 1];

      // Reduce the length of the indices array
      indicesArrayCount -= 1;
    }

    return sampleIndices;
  }
}
