// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface Ownership {
  function getDesigner() external view returns (address);

  function setDesigner(address newOwner) external;
}
