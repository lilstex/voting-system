# Voting System

<!-- https://www.ncc.edu/studentlife/images/Vote.jpg -->

The Voting System Contract is a decentralized application (dApp) built using Solidity on the Ethereum blockchain. This contract provides a secure, transparent, and tamper-proof method for conducting elections, ensuring the integrity and anonymity of votes cast by authorized participants. Below is an overview of its features and functionalities:

#### Features

1. **Candidate Management**:

   - **Add Candidate**: Allows the election organizer to add candidates to the election.
   - **Candidate Struct**: Stores the candidate's ID, name, and vote count.

2. **Voter Management**:

   - **Authorize Voter**: Grants eligible voters the right to vote in the election.
   - **Voter Struct**: Keeps track of whether a voter is authorized, has voted, and their vote choice.

3. **Voting Process**:

   - **Vote Function**: Enables authorized voters to cast their votes securely. Each voter can vote only once.
   - **Vote Tallying**: Automatically increments the vote count for the selected candidate and tracks the total number of votes cast.

4. **Election Control**:

   - **Ownership**: The contract owner (typically the election organizer) has exclusive rights to manage candidates and authorize voters.
   - **End Election**: Ends the election, announces the results, and logs the final vote counts for each candidate. The contract can then be self-destructed to clean up resources.

5. **Security and Transparency**:
   - **Event Logging**: Logs significant actions such as adding candidates, authorizing voters, and the final results, ensuring transparency.
   - **Modifiers**: Enforces access control, allowing only the contract owner to perform critical actions.

#### Contract Structure

- **State Variables**: Store information about candidates, voters, the election name, owner, and total votes.
- **Events**: Emit logs for significant actions for transparency and tracking.
- **Modifiers**: Ensure only authorized users (contract owner) can perform certain functions.

#### Functions

- **Constructor**: Initializes the contract with the election name and sets the contract deployer as the owner.
- **addCandidate**: Adds a new candidate to the election.
- **authorize**: Authorizes a voter to participate in the election.
- **vote**: Allows an authorized voter to cast their vote for a candidate.
- **end**: Ends the election, emits the final results, and self-destructs the contract.

#### Usage

1. **Deploy the Contract**: The contract is deployed on the Ethereum blockchain with an initial election name.
2. **Add Candidates**: The election organizer adds candidates to the contract.
3. **Authorize Voters**: The election organizer authorizes eligible voters.
4. **Voting**: Authorized voters cast their votes.
5. **End Election**: The election organizer ends the election and the final results are logged and announced.

This Voting System Contract provides a robust framework for conducting elections in a decentralized manner, ensuring security, transparency, and fairness in the voting process.
