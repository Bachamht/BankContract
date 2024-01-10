// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract Bank {

    constructor() {
        owner = msg.sender;
    }

    address private owner;
    mapping(address => uint) private  balances;
    uint [3] private topThree;
    uint private totalAmount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the administrator can withdraw money");
        _;
    }

    receive() external payable { 
        uint  amount = msg.value;
        balances[msg.sender] += amount;
        totalAmount += amount;
        uint  balance = balances[msg.sender];

        if (balance > topThree[0]) {
            topThree[0] =  amount;
            topThree[1] =  topThree[0];
            topThree[2] =  topThree[1];
        }
        if (balance > topThree[1]) {
            topThree[1] = balance;
            topThree[2] = topThree[1];
        }
        if (balance > topThree[2]) {
            topThree[2] = balance;
        }


    }

    
    //管理员取出所有ETH
    function ownerWithdraw() public onlyOwner{
        address payable administrator = payable(msg.sender);
        administrator.transfer(totalAmount);
    }
    //用户取出存款
    function userWithdraw() public {
        address payable user = payable(msg.sender);
        uint userBalance = balances[user];
        require(userBalance > 0,  "Your balance is less than 0"); 
        user.transfer(userBalance);

    }

    //查看银行存款总额
    function viewTotalAmount() public view onlyOwner returns(uint) {
        return totalAmount;
    }

    //查看存款前三的地址和余额
    function DepositTopThree() public view onlyOwner returns(uint[3] memory){
        return topThree;
    }

    //用户查看自身余额
    function viewBalance() public view returns(uint) {
        return balances[msg.sender];
    }

}
