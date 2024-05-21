const { ethers, getNamedAccounts } = require("hardhat")

async function main () {
    const { deployer } = getNamedAccounts() /** Get the address of the deployer */
    const voteSystem = await ethers.getContract("VoteSystem", deployer) /** Get the contract */
    console.log(`********Voting System Contract Retrieved At ${voteSystem.address}************`)
    console.log("***************Registering/Connecting Candidates****************")
    const accounts = await ethers.getSigners()
    for (i = 1; i <= 3; i++) {
        const connectedCandidates = await voteSystem.connect(
            accounts[i]
        )
        await connectedCandidates.addCandidate(accounts[i].address)
    }
    // Get a candidate
    const candidate = await voteSystem.getCandidate(accounts[1])
    console.log("********Here is the first candidate************")
    console.log(candidate)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })