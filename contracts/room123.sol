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

    function buy() payable public{
        uint256 requestedTokens = msg.value / 5;
        require(room123.balanceOf(address(this)) >= requestedTokens);
        require(requestedTokens > 0);
        room123.transfer(msg.sender, requestedTokens);
    }

    function offer(uint256 amount, uint256 paymentWei) public{
        require(amount > 0);
        require(room123.allowance(msg.sender, address(this)) >= amount);
        offerList.push(tokenOffer(msg.sender, amount, paymentWei));
    }
}