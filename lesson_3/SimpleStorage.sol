// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listofPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favNumber) public virtual  {
        myFavoriteNumber = _favNumber;
    }

    function retrive() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favNumber) public {
        listofPeople.push(Person(_favNumber, _name));
        nameToFavoriteNumber[_name] = _favNumber;
    }
}

contract SimpleStorage2 {
    //dummy contract
}
