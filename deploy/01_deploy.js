const { network } = require("hardhat")
const { verify } = require("../utils/verify")
const { developmentChains } = require("../helper/helperConfig")
require("dotenv").config()

modle.exports = async ({getNamedAccounts, deployments}) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const ELECTION_NAME = process.env.ELECTION_NAME || "Default Election"

    log("***************Deploying Vote System Contract******************************")
    const voteSystem = await deploy("VoteSystem", {
        from: deployer,
        args: [ELECTION_NAME],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log(`Voting System Deployed at ${voteSystem.address}`)

    // Verify contract if not in a local network
    if(!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
        await verify(voteSystem.address, [ELECTION_NAME])
        log("Voting System Contract Verified Successfully")
    }
}

module.exports.tag = ["all", "vote"]