
pragma solidity ^0.6.0;
import './ERC20Claimable.sol';


contract ExerciceSolution {

    // keep track of adresses who claim token and the amount
    mapping(address => uint256) public claimedTokenAddress;
    ERC20Claimable public Claimable;

    constructor( ERC20Claimable _claimableERC20) 
	public 
	{
		Claimable = _claimableERC20; //0xb5d82FEE98d62cb7Bc76eabAd5879fa4b29fFE94
	}

    //gets called when money is sent to this contract ;
    fallback () external payable 
	{}
    // called when ether is sent to a contract with no calldata , when no other function matches
	receive () external payable 
	{}

    // ex2_claimedFromContract
    // function to laiming tokens through ExerciceSolution Contract
    event claimed(address addrClaimer , bool status , uint256 amount);
    function claimTokensOnBehalf() public {
        //see last amount , balance of tokens claimed
        uint256 claimerBalance = Claimable.balanceOf(address(this));
        // claim tokens
        Claimable.claimTokens();
        // save new balance
        uint256 newClaimerBalance = Claimable.balanceOf(address(this));
        // save the varriation amount 
        uint256 update = newClaimerBalance - claimerBalance;
        // keep track of it 
        claimedTokenAddress[msg.sender]+= update;
        emit claimed(msg.sender,true,update);
    }
    // Verifying if ExerciceSolution kept track of [msg.sender] balance
	function tokensInCustody(address callerAddress) public returns (uint256) {

        // see the tracker 
        return claimedTokenAddress[callerAddress];

    }

    /*
    //ex3_withdrawFromContract
    // function to withdraw tokens through ExerciceSolution Contract
	function withdrawTokens(uint256 amountToWithdraw) public returns (uint256){

    }
    // ex6_depositTokens
    // function to deposit claimableTokens in ExerciceSolution Contract
	function depositTokens(uint256 amountToWithdraw) public returns (uint256){

    }
    // Get ExerciceSolutionERC20 address
	function getERC20DepositAddress() public returns (address){
        return adress;
    // */
}