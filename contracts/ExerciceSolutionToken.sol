pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ExerciceSolutionToken is ERC20{

    // keep track of adresses who are set to minter
    mapping(address => bool) public minters;
    uint8 public _decimals = 18; // decimals
    address public Owner; // Owner Addresse

	constructor(string memory name, string memory symbol,uint256 initialSupply) public ERC20(name, symbol) 
	{
        _setupDecimals(_decimals);
        _mint(msg.sender, initialSupply);
        minters[msg.sender] = true; // owner is a minter
        Owner = msg.sender;
	}

    modifier onlyOwner() {
        require(msg.sender == Owner );
        _;
    }

    //only the contract owner can set minters
    event isminter(address addr, bool status);
    function setMinter(address minterAddress, bool isMinter)  public
    onlyOwner
    {
        minters[minterAddress] = isMinter;
        emit isminter(minterAddress,true);
    }

    modifier onlyMinters() {
    require(minters[msg.sender]);
    _;
    }
    
	function isMinter(address minterAddress) public returns (bool){
        // return if isMinter
        return minters[minterAddress];
    }

    event Minted(address beneficiary, uint256 tokenAmount);
	function mint(address toAddress, uint256 amount)  public
    onlyMinters
    {
        _mint(toAddress, amount);
        emit Minted(toAddress, amount);
    }

    event Burned(address beneficiary, uint256 tokenAmount);
	function burn(address toAddress, uint256 amount)  public
    onlyMinters
    {
        _burn(toAddress, amount);
        emit Burned(toAddress, amount);
    }

}