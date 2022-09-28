// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract RoomToken is ERC20Token{
    string public name;
    string public symbol;
    address public admin;
    uint256 public totalTokens;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor(string memory _name, string memory _symbol, uint256 _totalTokens){
        name = _name;
        symbol = _symbol;
        totalTokens = _totalTokens;
        balances[msg.sender] = _totalTokens;
        admin = msg.sender;
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
        require(amount <= balances[spender]);
        
        allowances[spender][msg.sender] = amount;
        emit Approval(spender, msg.sender,amount);
        
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool){
        require(amount <= balances[sender]);
        require(amount <= allowances[sender][msg.sender]);
        
        balances[sender] = balances[sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        allowances[sender][msg.sender] = allowances[sender][msg.sender] - amount;
        emit Transfer(sender, recipient, amount);
        
        return true;
    }
}