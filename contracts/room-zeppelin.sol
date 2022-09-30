// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Room1412 is ERC20 {
    address public admin;

    constructor() ERC20("Room1412", "R12") {
        _mint(msg.sender, 100);
        admin = msg.sender;
    }
}