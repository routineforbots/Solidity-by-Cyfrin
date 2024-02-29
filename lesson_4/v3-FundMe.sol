// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {PriceConverter} from './v2-PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256; 

    address[] public funders;

    uint256 public minimumUSD = 5e18;

    address public owner; // used for constructor

    constructor() {
        owner = msg.sender;
    }

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;


    function fund() public payable {
        require(msg.value.getConversionRate() > minimumUSD, "did not send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value; 

    }


   function withdraw() public {
    // when can use modifiers if we have a lot of functions which must be only called by the owner
    // that is why we are commenting the following line and will create the modifier at the bottom
    // require(msg.sender == owner, "Must be the owner!"); // from the constructor

    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ /* increment by +1 */ ) {
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }

    funders = new address[](0);

    (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}(""); // within "" we can call specific function
    require(callSuccess, "Send failed"); //same thing to revert tx in case of error

   }
}
