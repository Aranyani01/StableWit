pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./EthUsdPriceFeed.sol"

// Whitepaper :  https://ipfs.io/ipfs/QmY1ux3avsMDEtpTAhSsEZyHaggcEFGZhNCg5MGH3qvSme


contract StableWit is ERC20, Ownable {
  constructor(address oracleContract) public ERC20("StableWit", "STW"){
    address oracleContractADD = oracleContract;
    contract PriceFeed = EthUsdPriceFeed(oracleContractADD);
  }

  function mint_STW(uint _amount) public {
    PriceFeed.requestUpdate();

    var ethval = msg.value;

    var currentvalue = PriceFeed.completeUpdate();
    var msgval = ethval * currentvalue;
    require(msgval > (110/100)*_amount), 'insufficient collateral provided'); //check if ether sent is sufficient collateral
    _mint(msg.send, _amount);
  }
