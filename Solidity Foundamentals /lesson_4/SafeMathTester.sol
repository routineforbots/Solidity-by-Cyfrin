// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester {

    uint8 public bigNumber = 255; //maximum number of uint8 is 255
    uint8 public bigNumber2 = 255;

    function add() public {
        bigNumber = bigNumber + 1; // it will reset 255 to 0 and starts adding +1 every time <= unchecked concept for Solidity bellow 0.8.x
        //SafeMath lab was used to mitigate this but after 0.8.0 version of Solidity
        //If we need old behaviour - we can use keyword unchecked and {}
        unchecked {bigNumber2 = bigNumber2 + 1;}
        //in some cases usage of unchecked can make contract more gas efficient
    }
}
