// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BMtokens is ERC20("blue", "BM") {
    address owner;

    constructor() {
        owner = msg.sender;
        _mint(address(this), 1000000e18);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}
