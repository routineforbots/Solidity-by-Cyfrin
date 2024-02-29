// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {PriceConverter} from './v2-PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256; //to attach functions in PriceConverter library to all uint256 as a methods 
    //in other words - all uint256s have an access to getConversionRate function

    address[] public funders;

    uint256 public minimumUSD = 5e18;

    address public owner; // used for constructor

    // we want the onwer of the contract to be able to withdraw so that the withdraw function can be only called by the owner
    // whenever this contract is deployed an owner is assigned to this contract with the following function build as constructior
    // constructior is a keyword and special function in solidity which immidiatly called when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;



    function fund() public payable {
        //Since we made an attachment, we can call getConversionRate() in a different way:
        // msg.value.getConversionRate() - for that notation msg.value - which is uint256 - gets passed to getConversionRate() function as a first argument "uint256 ethAmount"
        require(msg.value.getConversionRate() > minimumUSD, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value; 

    }



   function withdraw() public {
    require(msg.sender == owner, "Must be the owner!"); // from the constructor

    // we want to reset all the mappings 
    // for loop
    // [1, 2, 3, 4] elements
    //  0, 1, 2, 3  indexes
    // for( /* starting index, ending index, step amount */ )
    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ /* increment by +1 */ ) {
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }
    // reset the array
    funders = new address[](0); // we are resetting array by creating new one with the length of 0

    /* THEORY:

    // withdraw funds back to the function caller
    // there are 3 ways to do that
    
    // 1. transfer - send ETH from the different contracts to each other (with the use of payable addresses)
    // transfer can be used for transactions with gas less than 2300, otherwise it throws an error and the tx is reverted

    payable(msg.sender).transfer(address(this).balance ); // *this* keyword reffers to the whole contract FundMe
    // we are casting msg.sender with payable() so that
    // msg.sender which has type of *address* with the use of payable(msg.sender) will become *payable address*

    // 2. send - has the same limit of 2300 for gas, but it returns boolean anyway
    bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // but to revert transaction in case of error we need an additional line
    require(sendSuccess, "Send failed");

    */

    // 3. call - recommended way; low level powerfull command which doesn't have gas limit; returns boolean
    (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}(""); // within "" we can call specific function
    // without specifying function to call we are using this like a transaction
    // our function returns 2 vaiables: 
    // callSuccess - true/false
    // dataReturned - data which is returned by call function (needs *memory* keyword since it returns an array)
    require(callSuccess, "Send failed"); //same thing to revert tx in case of error

   }
}
