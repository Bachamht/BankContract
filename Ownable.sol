// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

/*
• 编写一个 BigBank 合约,要求:

• 仅 >0.001 ether(用modifier权限控制)可以存款

• 把管理员转移给 Ownable 合约,只有 Ownable 可以调用

    BigBank 的withdraw().

*/
import "./bank.sol";


contract Ownable {

    address internal contractOwner;
    address internal moneyOwner;
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Only the administrator can withdraw money");
        _;
    }

    modifier onlyMoneyOwner() {
        require(msg.sender == moneyOwner, "Only the administrator can withdraw money");
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

}