// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./room.sol";

contract Room123{
    RoomToken public room123;
    
    struct tokenOffer{
        address owner;
        uint256 amountOfTokens;
        uint256 pricePerToken;
    }

    tokenOffer[] public offerList;

    constructor(){
        room123 = new RoomToken("room123", "R123", 100);
        offerList.push(tokenOffer(address(this), room123.totalSupply(), 5));
    }

    function buy(uint id, uint256 amountToBuy) payable public{
        tokenOffer memory offerToBuy = offerList[id];
        uint256 finalPrice = offerToBuy.pricePerToken * amountToBuy;
        require(room123.balanceOf(msg.sender) >= finalPrice);
        require(amountToBuy > 0);
        room123.transferFrom(offerToBuy.owner, msg.sender, offerToBuy.amountOfTokens);
    }

    function offer(uint256 amount, uint256 paymentWei) public{
        require(amount > 0);
        require(room123.allowance(msg.sender, address(this)) >= amount);
        offerList.push(tokenOffer(msg.sender, amount, paymentWei));
    }
}