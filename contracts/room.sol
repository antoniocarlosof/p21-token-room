// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract RoomToken is Token{
    uint256 value;

    constructor(string memory _name, uint256 _value) Token(_name){
        value = _value;
    }
}