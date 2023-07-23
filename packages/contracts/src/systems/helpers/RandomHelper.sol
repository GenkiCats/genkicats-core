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

contract RandomHelper {
  struct RandomEvent {
    address owner;
    uint256 delayBlocks;
    uint256 totalShares;
  }
  struct Choice {
    uint256 choice;
    uint256 blockNumber;
  }

  mapping(uint256 => bytes32) public randomSeeds;
  mapping(bytes32 => RandomEvent) public randomEventsInfo;
  mapping(bytes32 => mapping(address => Choice)) public randomEventsChoice;

  // maximum number of blocks to retreat on this chain
  uint256 blockhashRetreat;

  constructor(uint256 _blockhashRetreat) {
    blockhashRetreat = _blockhashRetreat;
  }

  function commitBlock() public {
    randomSeeds[block.number - 1] = blockhash(block.number - 1);
  }

  function registerEvent(bytes32 eventId, uint256 delayBlocks, uint256 totalShares) public {
    RandomEvent storage randomEvent = randomEventsInfo[eventId];
    require(randomEvent.delayBlocks == 0, "event already registered");
    require(delayBlocks > 0, "delayBlocks must be greater than 0");
    require(totalShares > 1, "totalShares must be greater than 1");
    randomEvent.owner = msg.sender;
    randomEvent.delayBlocks = delayBlocks;
    randomEvent.totalShares = totalShares;
  }

  function changeEventDelay(bytes32 eventId, uint256 delayBlocks) public {
    RandomEvent storage randomEvent = randomEventsInfo[eventId];
    require(randomEvent.owner == msg.sender, "not owner");
    require(delayBlocks > 0, "delayBlocks must be greater than 0");
    randomEvent.delayBlocks = delayBlocks;
  }

  function changeEventTotalShares(bytes32 eventId, uint256 totalShares) public {
    RandomEvent storage randomEvent = randomEventsInfo[eventId];
    require(randomEvent.owner == msg.sender, "not owner");
    require(totalShares > 0, "totalShares must be greater than 0");
    randomEvent.totalShares = totalShares;
  }

  function getRandomNumber(bytes32 eventId, uint blockNumber) public view returns (uint256) {
    bytes32 randomSeed;
    if (block.number - blockNumber > blockhashRetreat) {
      require(randomSeeds[blockNumber] != 0, "randomSeed not found");
      randomSeed = randomSeeds[blockNumber];
    } else {
      randomSeed = blockhash(blockNumber);
    }
    uint256 randResult = uint256(keccak256(abi.encodePacked(eventId, blockNumber, randomSeed)));
    return randResult;
  }

  function choiceCommit(bytes32 eventId, uint256 choice) public {
    RandomEvent storage randomEvent = randomEventsInfo[eventId];
    require(choice < randomEvent.totalShares, "choice must be less than totalShares");
    randomEventsChoice[eventId][msg.sender] = Choice(choice, block.number);

    // commit blockhash if not committed
    if (randomSeeds[block.number - 1] == 0) {
      randomSeeds[block.number - 1] = blockhash(block.number - 1);
    }
  }

  function choiceReveal(bytes32 eventId) public view returns (bool) {
    RandomEvent storage randomEvent = randomEventsInfo[eventId];
    Choice storage choice = randomEventsChoice[eventId][msg.sender];
    uint256 targetBlockNumber = choice.blockNumber + randomEvent.delayBlocks;
    require(targetBlockNumber > block.number, "delayBlocks not reached");
    uint256 randNum = getRandomNumber(eventId, targetBlockNumber);
    if (choice.choice == randNum % randomEvent.totalShares) {
      return true;
    } else {
      return false;
    }
  }
}
