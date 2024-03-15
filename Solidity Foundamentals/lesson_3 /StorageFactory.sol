// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

//simple import of another contract:
// import "./SimpleStorage.sol";
//but named import - where we point to the specific contracts rather than whole .sol file - is beter:
import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";

contract StorageFactory0 {

    SimpleStorage public simpleStorage; // creation of variable of SimpleStorage contract type. Syntax: type -> visibility -> name


    function CreateSimpleStorageContract() public {
        //every time we call the function it will deploy new Simple Storage contract.
        simpleStorage = new SimpleStorage(); //variable gets value from which is return as the result execution of contract SimpleStorage() from SimpleStorage.sol
        //simpleStorage gets overwriten everytime when we call the function => let's create an array to track the SimpleStorage contracts (bellow)

    }
}

contract StorageFactory1 {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function CreateSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

function StorageFactoryStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
    //To interact with the contract we need address and ABI - Application Binary Interface
    SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
    mySimpleStorage.store(_newSimpleStorageNumber);
}

function StorageFactoryGet(uint256 _simpleStorageIndex) public view returns(uint256) {
    return listOfSimpleStorageContracts[_simpleStorageIndex].retrive();
}
}
