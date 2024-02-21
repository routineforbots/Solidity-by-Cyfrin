// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {PriceConverter} from './v2-PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256; //to attach functions in PriceConverter library to all uint256 as a methods 
    //in other words - all uint256s have an access to getConversionRate function

    address[] public funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //Since we made an attachment, we can call getConversionRate() in a different way:
        // msg.value.getConversionRate() - for that notation msg.value - which is uint256 - gets passed to getConversionRate() function as a first argument "uint256 ethAmount"
        require(msg.value.getConversionRate() > 1e18, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value; 

    }



   // function withdraw() public {}
}
