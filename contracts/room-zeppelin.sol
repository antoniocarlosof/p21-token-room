// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Room1412 is ERC20 {
    address public admin;
    uint256 public offerCount;

    struct tokenOffer{
        address payable owner;
        uint256 amountOfTokens;
        uint256 pricePerToken;
    }

    mapping(uint256 => tokenOffer) public offerList;
    mapping(address => uint256) public amountOffered;

    constructor() ERC20("Room1412", "R12") {
        offerCount = 0;

        _mint(msg.sender, 100);
        offerList[offerCount] = tokenOffer(payable(msg.sender), totalSupply(), 5000);
        amountOffered[msg.sender] = totalSupply();
        offerCount++;
        
        admin = msg.sender;
    }

    function buy(uint256 _offerId, uint256 amountToBuy) payable public {
        require(amountToBuy > 0, "Desired amount of tokens must be greater than 0");
        
        tokenOffer memory offerToBuy = offerList[_offerId];
        bool transaction = offerToBuy.owner.send(msg.value);
        require(transaction, "ETH transaction failure");

        _transfer(offerToBuy.owner, msg.sender, amountToBuy);
        if (offerToBuy.amountOfTokens > amountToBuy) {
            offerToBuy.amountOfTokens = offerToBuy.amountOfTokens - amountToBuy;
            offerList[_offerId] = offerToBuy;
        } else {
            delete offerList[_offerId];
        }
        amountOffered[offerToBuy.owner] = amountOffered[offerToBuy.owner] - amountToBuy;
    }

    function offer(uint256 amount, uint256 paymentWei) public {
        require(amount > 0, "Offered amount of tokens must be greater than 0");
        require(balanceOf(msg.sender) >= amountOffered[msg.sender] + amount, "Not enough balance. You must not offer more than your current balance");

        offerList[offerCount] = tokenOffer(
            payable(msg.sender),
            amount,
            paymentWei
        );

        amountOffered[msg.sender] = amountOffered[msg.sender] + amount;

        offerCount++;
    }
}