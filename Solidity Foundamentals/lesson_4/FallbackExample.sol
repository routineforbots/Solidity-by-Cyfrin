// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallBackExample {
    uint256 public result;

    // receive() gets triggered anytime we send tx to this contract and we don't specify a function and CALLDATA is blank
    receive() external payable {
        result = 1;
     }

     // if function is wrongly specified than we can use Fallback function
     fallback() external payable {
        result = 2;
      }
}

/* THEORY

Ether is sent to contract 
        is msg-data empty?
                /    \
             yes      no
             /         \
        receive()?      fallback()
          /    \
         yes   no
          /    \
   receive()   fallback()

*/
