// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // --- Struct ---
    struct Candidate {
        string name;
        uint voteCount;
    }

    // --- State variables ---
    address public owner;
    uint public candidatesCount;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    // --- Event ---
    event Voted(address indexed voter, uint candidateId);

    // --- Modifier ---
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // --- Constructor ---
    constructor() {
        owner = msg.sender;
    }

    // --- Thêm ứng viên (chỉ owner) ---
    function addCandidate(string memory _name) public onlyOwner {
        candidates[candidatesCount] = Candidate(_name, 0);
        candidatesCount++;
    }

    // --- Vote cho ứng viên ---
    function vote(uint candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateId < candidatesCount, "Invalid candidate ID");

        candidates[candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, candidateId);
    }

    // --- Lấy thông tin ứng viên ---
    function getCandidate(uint candidateId) public view returns (string memory, uint) {
        require(candidateId < candidatesCount, "Invalid candidate ID");
        Candidate memory c = candidates[candidateId];
        return (c.name, c.voteCount);
    }
}