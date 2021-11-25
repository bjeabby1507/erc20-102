var TDErc20 = artifacts.require("ERC20TD.sol");
var ERC20Claimable = artifacts.require("ERC20Claimable.sol");
var evaluator = artifacts.require("Evaluator.sol");

var ExerciceSolution = artifacts.require("ExerciceSolution.sol");

module.exports = async function (deployer) {
    //await deployer.deploy(TDErc20,"TD-ERC20-101","TD-ERC20-101",web3.utils.toBN("20000000000000000000000000000"));
    //var TDToken= await TDErc20.deployed();

    //await deployer.deploy(ERC20Claimable,"ClaimableToken","CLTK",web3.utils.toBN("20000000000000000000000000000"));
    //var ClaimableToken = await ERC20Claimable.deployed();

    //await deployer.deploy(evaluator,TDToken.address, ClaimableToken.address);
    //var Evaluator= await evaluator.deployed();
    
    //await TDToken.setTeacher(Evaluator.address, true)

    // await deployer.deploy(ExerciceSolution,ClaimableToken.address );//for Ganache
    await deployer.deploy(ExerciceSolution,'0xb5d82FEE98d62cb7Bc76eabAd5879fa4b29fFE94' );
    var Solution = await ExerciceSolution.deployed();

    //console.log("TDToken " + TDToken.address)
	//console.log("ClaimableToken " + ClaimableToken.address)
	//console.log("Evaluator " + Evaluator.address)
    console.log("ExerciceSolution " + Solution.address)
};