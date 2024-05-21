// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error NotOwner();

/**
 *  @title A voting system
 * @author Emmanuel Mbagwu
 * @notice You can use this contract for simple voting exercises
 */
contract VoteSystem {
    /**
     *  @title Candidate object
     * @notice Holds the details of a candidate
     */
    struct Candidate {
        uint256 id;
        address candidateAddress;
        uint256 voteCount;
    }

    /**
     *  @title Voter object
     * @notice Holds the details of a voter
     */
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

    /**
     * @notice An event that has the result of the voting
     */
    event VoteResult(
        uint256 candidateId,
        address candidateAddress,
        uint256 voteCount
    );

    /**
     * @notice A constructor that initializes the contract with a name for the election
     */
    constructor(string memory _name) {
        i_owner = msg.sender;
        electionName = _name;
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    /**
     * @notice Adds a candidate to the candidates list for the election
     * @param _candidateAddress the name of the candidate
     * @dev Increments the number of candidates in the candidate list
     */
    function addCandidate(address _candidateAddress) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            _candidateAddress,
            0
        );
    }

    /**
     * @notice Authorizes voters for the voting exercise
     * @param _voterAddress the index of the voter
     * @dev Increments the number of authorized voters
     */
    function authorizeVoter(address _voterAddress) public onlyOwner {
        require(!votingEnded, "Voting has already ended.");
        totalVoters++;
        voters[_voterAddress].authorised = true;
    }

    /**
     * @notice Authorised voters are allowed to cast their votes
     * @param candidateId the index of the candidate
     * @dev Increments the candidates vote count, and marks voter to have voted
     */
    function vote(uint256 candidateId) public {
        require(
            !voters[msg.sender].authorised,
            "You are not authorised to vote"
        );
        require(!votingEnded, "Voting has already ended.");
        require(voters[msg.sender].voted, "You already voted");
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = candidateId;

        candidates[candidateId].voteCount += 1;
        totalVotes += 1;
    }

    /**
     * @notice A function to end voting
     * @dev Loops through the candidates list and emits their results
     */
    function end() public onlyOwner {
        require(!votingEnded, "Voting has ended.");

        for (uint256 i = 1; i <= candidatesCount; i++) {
            emit VoteResult(
                candidates[i].id,
                candidates[i].candidateAddress,
                candidates[i].voteCount
            );
        }

        votingEnded = true;
    }

    /**
     * @notice A view function that returns contract owner
     */
    function getOwner() public view returns (address) {
        return i_owner;
    }

    /**
     * @notice returns a voter
     * @param voterAddress of the voter
     */
    function getVoter(address voterAddress) public view returns (Voter memory) {
        return voters[voterAddress];
    }

    /**
     * @notice returns a candidate
     * @param index of the candidate
     */
    function getCandidate(
        uint256 index
    ) public view returns (Candidate memory) {
        return candidates[index];
    }
}
