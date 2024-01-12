// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./bank.sol";


contract Ownable {

    address internal contractOwner;
    address internal moneyOwner;
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not administrator");
        _;
    }

    modifier onlyMoneyOwner() {
        require(msg.sender == moneyOwner, "Not moneyOwner");
        _;
    }

    constructor() {
        contractOwner = msg.sender;
    }

    // 给地址授权取出所有钱的资格
    function manageOwner(address newOwner) public onlyContractOwner{
        moneyOwner = newOwner;
    }
    
    //moneyOwner取钱
    function withdraw(address bankContract) public onlyMoneyOwner {
        IWithdraw(bankContract).ownerWithdraw();
    }
    
    receive() external payable { }

}