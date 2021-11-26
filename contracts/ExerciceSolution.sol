
pragma solidity ^0.6.0;
import './ERC20Claimable.sol';
import './ExerciceSolutionToken.sol';

contract ExerciceSolution {

    // keep track of adresses who claim token and the amount
    mapping(address => uint256) public claimedTokenAddress;
    ERC20Claimable public Claimable;
    ExerciceSolutionToken public Token;

    constructor( ERC20Claimable _claimableERC20, ExerciceSolutionToken _tokenDepositAdr) 
	public 
	{
		Claimable = _claimableERC20; //0xb5d82FEE98d62cb7Bc76eabAd5879fa4b29fFE94
        Token = _tokenDepositAdr;
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

    //ex3_withdrawFromContract
    // function to withdraw tokens through ExerciceSolution Contract
    event withdrawn(address addrwithdrawer , bool status , uint256 amount);
	function withdrawTokens(uint256 amountToWithdraw) public returns (uint256){

        // Checking how many tokens the Withdrawer hold and can withdraw
        uint256 claimerBalance = claimedTokenAddress[msg.sender];
        require(claimedTokenAddress[msg.sender] > 0, "You can't withdraw, you hold no token");
        // suffisant amount of token ?
        require(claimedTokenAddress[msg.sender] >= amountToWithdraw, "You can't withdraw, no enough tokens");

        //withdraw , check and keep track of tokens
        //Claimable.transfer(msg.sender,amountToWithdraw);
        if(Claimable.transfer(msg.sender,amountToWithdraw))
        {
            //update tokensInCustody
            claimedTokenAddress[msg.sender] = claimerBalance - amountToWithdraw;
            //update the balance is tokenized : burn the withdrawn tokens
            Token.burn(msg.sender,amountToWithdraw);
            emit withdrawn(msg.sender, true, amountToWithdraw);
            return amountToWithdraw;
        }
    }
    
    // ex6_depositTokens
    // function to deposit claimableTokens in ExerciceSolution Contract
    event deposit(address addrdepositor, bool status , uint256 amount);
	function depositTokens(uint256 amountToDeposit) public returns (uint256){

        uint256 claimerBalance = claimedTokenAddress[msg.sender];
        require(amountToDeposit > 0, "no token to deposit");
        // we will be allowed to manipulate msg.sender token with the amount to deposit
        // lets transfer the token in ExerciceSolution contract
        if(Claimable.transferFrom(msg.sender,address(this),amountToDeposit))
        {
            //update tokensInCustody that belongs to depositor
            claimedTokenAddress[msg.sender] = claimerBalance + amountToDeposit;
            //update the balance is tokenized
            Token.mint(msg.sender,amountToDeposit);
            emit deposit(msg.sender, true, amountToDeposit);
            return amountToDeposit;
        }
    }
    // Get ExerciceSolutionERC20Token address
	function getERC20DepositAddress() public returns (address){
        return address(Token);
    }
}