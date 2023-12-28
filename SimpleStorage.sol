// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.22; // stating the usage of .22 version of solidity and newer

// more specific declaration of version: pragma solidity >=0.8.22 <0.8.24


/*
Basic Types: 
boolean, 
uint (positive whole number), 
int(negative/positive whole number), 
address, 
bytes, 
string
*/

contract TypesExamples {
    bool hasFavouriteNumber = true;
    uint256 favouriteNumber = 88; //uint256 == uint in terms of size in memory
    int256 favouriteNumber2 = -88;
    string favouriteNumberInText = "88";
    address myAddress = 0x76F5849baA479b15246a6D189ca3a0bA6E8Ea64D;
    bytes32 favouriteBytes32 = "cat"; // string object actually got converted to the bytes object and looks like (HEX): 0x2aser25
    //bytes and bytes with the number (e.g. bytes32) are diferent things

    //Default values of the types in no value is given
    uint256 favouriteNumber; //it has default value is 0
    bool isMarked; // it has default value is false
}

//Functions

contract SimpleStorage {
 
    uint256 public favouriteNumber; //default visibility is internal unless the public keyword is used
    //public keyword also gets getter function to the variable
    //all visibility parameters are related to scope - be able to call inside/outside context: public, private, external, internal

    function store(uint256 _favNumber) public {
        favouriteNumber = _favNumber;
    }

    //view, pure keywords are to indicate that we just want to read and not to perform transaction
    //pure will return the number related to a state, view will return the actual value
    function retrieve() public view returns(uint256) {
        return favouriteNumber;
    }

    
}

