// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./room.sol";

contract Room123{
    RoomToken public room123;
    uint256 tokenCount;
    
    struct tokenOffer{
        uint id;
        address owner;
        uint256 amountOfTokens;
        uint256 pricePerToken;
    }

    tokenOffer[] public offerList;
    mapping(address => uint) public amountOffered;

    constructor(){
        tokenCount = 0;
        room123 = new RoomToken("room123", "R123", 100);
        offerList.push(tokenOffer(tokenCount, address(this), room123.totalSupply(), 5));
        amountOffered[msg.sender] = room123.totalSupply();
    }

    function allowSystem(uint256 amount) public{
        uint256 newAllowance = room123.allowance(msg.sender, address(this)) + amount;
        require(room123.balanceOf(msg.sender) >= newAllowance);
        room123.approve(msg.sender, newAllowance);
    }

    function buy(uint id, uint amountToBuy) payable public{
        require(amountToBuy > 0);
        tokenOffer memory offerToBuy = offerList[id];
        uint finalPrice = offerToBuy.pricePerToken * amountToBuy;
        require(payable(offerToBuy.owner).send(finalPrice));
        room123.transferFrom(offerToBuy.owner, msg.sender, amountToBuy);
        amountOffered[offerToBuy.owner] = amountOffered[offerToBuy.owner] - amountToBuy;
        offerToBuy.amountOfTokens = offerToBuy.amountOfTokens - amountToBuy;
        offerList[id] = offerToBuy;
    }

    function offer(uint amount, uint256 paymentWei) public{
        uint totalOfferIntention = amountOffered[msg.sender] + amount;
        require(amount > 0);
        require(room123.allowance(msg.sender, address(this)) >= amount);
        require(room123.balanceOf(msg.sender) >= totalOfferIntention);
        amountOffered[msg.sender] = totalOfferIntention;
        tokenCount++;
        offerList.push(tokenOffer(tokenCount, msg.sender, amount, paymentWei));
    }
}