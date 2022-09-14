// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract RoomToken is ERC20Token{
    string public name;
    uint256 public totalTokens;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor(string memory _name, uint256 _totalTokens){
        name = _name;
        totalTokens = _totalTokens;
    }

    function totalSupply() public override view returns (uint256){
        return totalTokens;
    }
    function balanceOf(address account) public override view returns (uint256){
        return balances[account];
    }
    function allowance(address owner, address spender) public override view returns (uint256){
        return allowances[owner][spender];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool){
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    function approve(address spender, uint256 amount) public override returns (bool){
        require(amount <= balances[msg.sender]);
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool){

    }
}