// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// TEST1

// A swap smart contract
//         write a swap smart contract that allow users to swap between two tokens;

// for example you want to build a smart contract that allows you to swap from link token to W3B token,
//         you need to determine the price of link token and web3bridge token,
//                 Assuming link is $50,
//                 Assuming W3B is $200,
//     Assuming a user wants to swap link to W3 token.
//     he needs to create an order, by putting all informaton necessary eg, the token address he wants to swap,the token address he wants to receive, the amount he want to swap, and deadline.
//     you can use struct to identify each order. and a mapping of uint to struct to identify each order,

//      after someone has created an order, another user can decide to execute the order by inputing the id of the order he wants to execute and  sending the token to the while he get the token that was use to execute order.

//      hint: you would need a price feed you actuallyy calculated in your smart contract.

//      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//      create an order-based swap contract that allows users to deposit various kind of tokens. These tokens can be purchased by others with another token specified by the depositors.

// For example; Ada deposits 100 link tokens, she wants in return, as a pay, 20 W3B tokens for for 100 link.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// we swap from token to eth to token and token to eth

contract swapFireon is ERC20("fireON", "F10") {
    address owner;

    //only BM token is swap here please

    constructor() payable {
        owner = msg.sender;
        _mint(address(this), 1000000000e18);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    mapping(address => uint) eth_token;
    mapping(address => uint) token_eth;

    function ethtotoken() external payable {
        require(msg.value > 0, "zero not allowed");
        require(msg.sender != address(0), "not zero address");
        uint RealAmount = pricingSystemforEthtoToken(msg.value);
        _transfer(address(this), msg.sender, RealAmount);
    }

    function tokentoeth(uint amount) external {
        require(amount > 0, "zero eth not allowed");
        _transfer(msg.sender, address(this), amount);
        uint transferAmount = priceSystemFortokentoEth(amount);
        (bool sent, ) = address(this).call{value: transferAmount}("");
        require(sent, "failed");
    }

    function tokentotoken() external {}

    function pricingSystemforEthtoToken(uint _amount)
        public
        pure
        returns (uint)
    {
        /// note that 100 wei is equal to 1 fireON
        uint realAmount = _amount / 10;

        return realAmount;
    }

    function priceSystemFortokentoEth(uint _amount) public pure returns (uint) {
        uint ethtoTransfer = _amount * 5;
    }
}
