var TDErc20 = artifacts.require("ERC20TD.sol");
var ERC20Claimable = artifacts.require("ERC20Claimable.sol");
var evaluator = artifacts.require("Evaluator.sol");

var ExerciceSolution = artifacts.require("ExerciceSolution.sol");
var ExerciceSolutionToken = artifacts.require("ExerciceSolutionToken.sol");

module.exports = async function (deployer) {
    //await deployer.deploy(TDErc20,"TD-ERC20-101","TD-ERC20-101",web3.utils.toBN("20000000000000000000000000000"));
    //var TDToken= await TDErc20.deployed();

    //await deployer.deploy(ERC20Claimable,"ClaimableToken","CLTK",web3.utils.toBN("20000000000000000000000000000"));
    //var ClaimableToken = await ERC20Claimable.deployed();

    //await deployer.deploy(evaluator,TDToken.address, ClaimableToken.address);
    //var Evaluator= await evaluator.deployed();
    
    //await TDToken.setTeacher(Evaluator.address, true)

    await deployer.deploy(ExerciceSolutionToken,"SolutionToken","EXTK",web3.utils.toBN("20000000000000000000000000000"));
    var SolutionToken = await ExerciceSolutionToken.deployed();

    //await deployer.deploy(ExerciceSolution,ClaimableToken.address );//for Ganache at creation
    //await deployer.deploy(ExerciceSolution,'0x9e9439C0398306822F711DE40247C74d5fee8dDC',SolutionToken.address );//for Ganache at creation with Token
    //await deployer.deploy(ExerciceSolution,'0x9e9439C0398306822F711DE40247C74d5fee8dDC' );//for Ganache
    await deployer.deploy(ExerciceSolution,'0xb5d82FEE98d62cb7Bc76eabAd5879fa4b29fFE94',SolutionToken.address ); // with Token
    //sawait deployer.deploy(ExerciceSolution,'0xb5d82FEE98d62cb7Bc76eabAd5879fa4b29fFE94');
    var Solution = await ExerciceSolution.deployed();

    //console.log("TDToken " + TDToken.address)
	//console.log("ClaimableToken " + ClaimableToken.address)
	//console.log("Evaluator " + Evaluator.address)
    console.log("ExerciceSolutionToken " + SolutionToken.address)
    console.log("ExerciceSolution " + Solution.address)
    
};