pragma solidity ^0.5.5;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale{
    
    constructor(
        uint128 rate,
        address payable wallet,
        KaseiCoin token
    ) public Crowdsale(rate, wallet, token) {
    }
}


contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
       string memory name,
       string memory symbol,
       address payable wallet
    ) public {
        KaseiCoin kasei_coin = new KaseiCoin(name, symbol, 0);
        
        kasei_token_address = address(kasei_coin);

        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, kasei_coin);
            
        kasei_crowdsale_address = address(kasei_crowdsale);

        kasei_coin.addMinter(kasei_crowdsale_address);
        
        kasei_coin.renounceMinter();
    }
}
