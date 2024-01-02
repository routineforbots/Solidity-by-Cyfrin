// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

//simple import of another contract:
// import "./SimpleStorage.sol";
//but named import - where we point to the specific contracts rather than whole .sol file - is beter:
import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage public simpleStorage; // creation of variable of SimpleStorage contract type. Syntax: type -> visibility -> name


    function CreateSimpleStorageContract() public {
        simpleStorage = new SimpleStorage(); //variable gets value from which is return as the result execution of contract SimpleStorage() from SimpleStorage.sol

        
    }
}

