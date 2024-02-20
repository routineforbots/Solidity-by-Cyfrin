// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // named import of interface from GitHub (via npm package manager)

/* Transactions Fields (can be also populated and sent during function call!:
Nonce: tx count for the account
Gas Price: price per unit of gas (in wei)
Gas Limit: max gas that this tx can use
To: address that the tx is sent to
Value: amount of wei to send
Data: what to send to the To address
v, r, s: components of tx signature (cryptography related)
*/




/* Functionality of this contract
- Get funds from users
- Withdraw funds to the owner of the contract
- Set a minimum funding value in USD
*/


contract FundMe {

// payable keyword enables contract to interact with funds (~ to act like a wallet)

    uint256 public myValue = 1; //value to showcase transaction revert

    function fundIntro() public payable  {

        // 1. How to send ETH to this contract - add keyword payable to the function 

        // 2. Set message parameters - msg.value is the checker for the number of wei sent with the transaction; 
        // in case of falure - revert transaction and show the predefined error message
        myValue = myValue + 2;
        require(msg.value > 1e18, "didn't send enough ETH"); // require is used to set minimum amount of wei: 1e18 = 1 ETH = 1 * 10 ** 18

        //revert means - undo any actions in that function that have been done (will cost gas!) and send the remaining gas back
        //so in our case if require() is not fulfilled, the myValue will not be increased by +2


    }

    uint256 public minUsd = 5 * (10 ** 18); // 5 represented in format of 5e18
    function fund() public payable {
        // allow users to send money
        // have a minimum $ sent as $5
        require(getConversionRate(msg.value) >= minUsd, "you are sending not enough ETH");
    }
    //we need function which uses Oracle (Chainlink) to get current price of ETH in terms of USD
    function getPrice() public view returns (uint256) {
        // we need an address of Chainlink contract: 0x694AA1769357215DE4FAC081bf1f309aDC325306

        // we need an ABI via so called interface - the structure which defines function as a placeholder (even without any defined logic inside)
        // in general interface provides us with ABI and acts as an API so that we don't care about the internal logic.
        // this internal logic is defined iтside particular object which we are calling as a parameter (e.g. contract 0x694AA1769357215DE4FAC081bf1f309aDC325306)
        // and internal logic is defined under the function with the same name as it is defined in interface (e.g. version() )
        // example: return AggregatorV3Interface(0x694A1769357215DE4FAC081bf1f309aDC325306).version();
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        /*
        we are returning multiple variables from the interface: 
        (uint80 roundId, int answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();
        the description of these variables is located here: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
        
        but we only need one variable to be returned:
        */
        (, int256 price, , , ) = priceFeed.latestRoundData();

        // int256 answer - is in our case is price of ETH in terms of USD and returns value without decimals, e.g. 4000.00000000
        return uint256(price) * 1e10; // we are normalizing int answer and msg.value and making a type casting int -> uint256
        //BTW in Solidity we don't have decimal numbers and only work with the whole numbers!!!
    }


    //function which performs conversion of provided value based on current price of ETH in USD
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();

        //and we are deviding by 1e18 because: 
        // 1000000000000000000 * 1000000000000000000 = 1000000000000000000000000000000000000 which is 32 places and we need to reduce back to 18 places - 1000000000000000000
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18; //we always multiply in Solidity before we devide because we operate with a whole numbers and not in decimal!
        return ethAmountInUsd;

        /* Example
        What is the price of 1 ETH (ethAmount) = 1_000000000000000000
        We get current ethPrice (2000_000000000000000000 - a lot of zeros after floating point represented as a whole number)
        The output will be: (2000_000000000000000000 * 1_000000000000000000) / 1e18 = $2000 = 1ETH
        */

    }

    



   // function withdraw() public {}
   // this function allows owner of the contract to withdraw funds

}
