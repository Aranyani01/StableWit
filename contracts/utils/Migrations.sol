// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Migrations {
  address public owner;
  uint public lastCompletedMigration;

  constructor() {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner)
    _;
  }

  function setCompleted(uint _completed) public restricted {
    lastCompletedMigration = _completed;
  }

  function upgrade(address _newAddress) public restricted {
    Migrations upgraded = Migrations(_newAddress);
    upgraded.setCompleted(lastCompletedMigration);
  }
}