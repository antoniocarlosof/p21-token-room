// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./room.sol";

contract Room123 is RoomToken{
    RoomToken room123 = new RoomToken("room123", "R123", 100);
}