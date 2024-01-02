// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {SimpleStorage} from "./SimpleStorage.sol";

//inheritence of the other contract to make a child contract
contract AddFiveStorage is SimpleStorage {

    //and we can change behavior of the contract with the custom functionality
    //this is called - an override which must be defined with 2 keywords: override - in child, virtual - in parrent
    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }

}
