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
    }

    function allowSystem(uint256 amount) public{
        uint256 newAllowance = room123.allowance(msg.sender, address(this)) + amount;
        require(room123.balanceOf(msg.sender) >= newAllowance);
        room123.approve(msg.sender, newAllowance);
    }

    function buy(uint id, uint256 amountToBuy) payable public{
        // Must implement update on offerList after transaction
        tokenOffer memory offerToBuy = offerList[id];
        uint256 finalPrice = offerToBuy.pricePerToken * amountToBuy;
        require(room123.balanceOf(msg.sender) >= finalPrice);
        require(amountToBuy > 0);
        room123.transferFrom(offerToBuy.owner, msg.sender, offerToBuy.amountOfTokens);
    }

    function offer(uint amount, uint256 paymentWei) public{
        require(amount > 0);
        require(room123.allowance(msg.sender, address(this)) >= amount);
        amountOffered[msg.sender] = amountOffered[msg.sender] + amount;
        require(room123.balanceOf(msg.sender) >= amountOffered[msg.sender]);
        tokenCount++;
        offerList.push(tokenOffer(tokenCount, msg.sender, amount, paymentWei));
    }
}