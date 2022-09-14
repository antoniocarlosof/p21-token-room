// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract RoomToken is ERC20Token{
    string public name;
    uint256 public amountOfTokens;

    constructor(string memory _name, uint256 _amountOfTokens){
        name = _name;
        amountOfTokens = _amountOfTokens;
    }

    function totalSupply() external view returns (uint256){
        return amountOfTokens;
    }
    function balanceOf(address account) external view returns (uint256){

    }
    function allowance(address owner, address spender) external view returns (uint256){

    }

    function transfer(address recipient, uint256 amount) external returns (bool){

    }
    function approve(address spender, uint256 amount) external returns (bool){

    }
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        
    }
}