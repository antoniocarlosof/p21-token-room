// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Room1412 is ERC20 {
    address public admin;
    uint256 offerId;

    struct tokenOffer{
        address payable owner;
        uint256 amountOfTokens;
        uint256 pricePerToken;
    }

    mapping(uint256 => tokenOffer) public offerList;
    mapping(address => uint256) public amountOffered;

    constructor() ERC20("Room1412", "R12") {
        offerId = 0;

        _mint(msg.sender, 100);
        offerList[offerId] = tokenOffer(payable(msg.sender), totalSupply(), 5000);
        amountOffered[msg.sender] = totalSupply();
        
        admin = msg.sender;
    }
}