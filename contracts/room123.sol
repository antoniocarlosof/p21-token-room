// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./room.sol";

contract Room123 is RoomToken{
    RoomToken public room123;

    constructor(){
        room123 = new RoomToken("room123", "R123", 100);
    }

    function buy() payable public{
        uint256 requestedTokens = msg.value / 5;
        require(room123.balanceOf(address(this)) >= requestedTokens);
        require(requestedTokens > 0);
        room123.transfer(msg.sender, requestedTokens);
    }

    function sell(uint256 amount) public{

    }
}