// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

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



    function fund() public payable  {
        // allow users to send money
        // have a minimum $ sent

        // 1. How to send ETH to this contract - add keyword payable to the function 

        // 2. Set message parameters - msg.value is the checker for the number of wei sent with the transaction; 
        // in case of falure - revert transaction and show the predefined error message
        myValue = myValue + 2;
        require(msg.value >= 1e18, "didn't send enough ETH"); // require is used to set minimum amount of wei: 1e18 = 1 ETH = 1 * 10 ** 18

        //revert means - undo any actions in that function that have been done (will cost gas!) and send the remaining gas back
        //so in our case if require() is not fulfilled, the myValue will not be increased by +2


    }

   // function withdraw() public {}
   // this function allows owner of the contract to withdraw funds

}
