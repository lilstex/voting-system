// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error NotOwner();

contract VoteSystem {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool authorised;
        bool voted;
        uint256 vote;
    }

    address public i_owner;
    string public electionName;
    uint256 public candidatesCount;
    uint256 public totalVotes;
    uint256 public totalVoters;
    bool public votingEnded;

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;

    event VoteResult(
        uint256 candidateId,
        string candidateName,
        uint256 voteCount
    );

    constructor(string memory _name) {
        i_owner = msg.sender;
        electionName = _name;
    }

    modifier onlyOwner() {
        if (msg.sender == i_owner) revert NotOwner();
        _;
    }

    // Function to add candidate for the election
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to authorize voters for the voting process
    function authorizeVoter(address _person) public onlyOwner {
        require(!votingEnded, "Voting has already ended."); // Check if voting has ended
        totalVoters++;
        voters[_person].authorised = true;
    }

    // Function to cast votes by authorised voters
    function vote(uint256 candidateId) public {
        require(
            !voters[msg.sender].authorised,
            "You are not authorised to vote"
        ); // Check if voter is authorised
        require(!votingEnded, "Voting has already ended."); // Check if voting has ended
        require(voters[msg.sender].voted, "You already voted"); // Check if voter already voted
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = candidateId;

        // Update candidates vote
        candidates[candidateId].voteCount += 1;
        // Update total votes cast
        totalVotes += 1;
    }

    // Function to end election and announce results
    function end() public onlyOwner {
        require(!votingEnded, "Voting has ended.");
        // Loop through the candidates to emit the election result
        for (uint256 i = 1; i <= candidatesCount; i++) {
            emit VoteResult(
                candidates[i].id,
                candidates[i].name,
                candidates[i].voteCount
            );
        }

        votingEnded = true;
    }
}
