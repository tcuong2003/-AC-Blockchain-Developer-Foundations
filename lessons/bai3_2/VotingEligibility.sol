// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

contract VotingEligibility {
    uint public minAge;
    address public owner;

    constructor() {
        minAge = 18;
        owner = msg.sender;
    }

    function checkEligibility(uint _age) public view returns (bool) {
        return _age >= minAge;
    }

    function setMinAge(uint _minAge) public {
        require(msg.sender == owner, "Only owner can set minimum age");
        minAge = _minAge;
    }
}