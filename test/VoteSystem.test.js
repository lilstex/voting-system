const { ethers } = require("hardhat")
const { assert } = require("chai")

describe("VoteSystem", () => {
    let voteSystemFactory, votingInstance
    beforeEach(async () => {
        voteSystemFactory = await ethers.getContractFactory("VoteSystem")
        votingInstance = await voteSystemFactory.deploy("Miss World 2024")
    })

    it("should initialize the voting system with the correct name", async () => {        
        const electionName = await votingInstance.electionName()
        const expectedValue = "Miss World 2024"
        assert.equal(electionName, expectedValue)
    });

    it("should add a candidate correctly", async () => {
        await votingInstance.addCandidate("Mary");
        const candidate = await votingInstance.candidates(1);
        assert.equal(candidate.name, "Mary");
    });
    
    // it("should authorize a voter", async () => {
    //     await votingInstance.authorizeVoter(accounts[1]);
    //     const voter = await votingInstance.voters(accounts[1]);
    //     assert.equal(voter.authorized, true);
    // });
    
    // it("should allow a voter to vote", async () => {
    //     await votingInstance.authorizeVoter(accounts[1]);
    //     await votingInstance.vote(1, { from: accounts[1] });
    //     const candidate = await votingInstance.candidates(1);
    //     assert.equal(candidate.voteCount, 1);
    // });
    
    // it("should end the election and emit results", async () => {
    //     await votingInstance.end();
    // });

})
