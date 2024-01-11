// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Bank {

    constructor() {
        owner = msg.sender;
    }

    address private owner;
    mapping(address => uint) private  balances;
    address [3] private topThree;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the administrator can withdraw money");
        _;
    }
    
    receive() external payable { 
        deposit();
    }

    //用户存款
    function deposit() private {
        
        uint  amount = msg.value;
        address user = msg.sender;
        balances[user] += amount;
        uint min = balances[user];
        uint minIndex = 3;
        for (uint i = 0; i < 3; i++) {
            if (topThree[i] == user) {
                minIndex = 3;
                break;
            }
            if (balances[topThree[i]] < min) {
                min = balances[topThree[i]];
                minIndex = i;
            }
        }
        if (minIndex < 3) {
            topThree[minIndex] = user;
        }
    }


    //管理员取出所有ETH
    function ownerWithdraw() public onlyOwner{
        address payable administrator = payable(msg.sender);
        administrator.transfer(address(this).balance);
        balances[administrator] = 0;
    }

    //用户取出存款
    function userWithdraw() public {
        address payable user = payable(msg.sender);
        uint userBalance = balances[user];
        require(userBalance > 0,  "Your balance is less than 0"); 
        user.transfer(userBalance);
        balances[user] = 0;
    }

    //查看银行存款总额
    function viewTotalAmount() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    //查看存款前三的金额
    function viewTopThree() public view onlyOwner returns(address[3] memory){
        return topThree;
    }

    //用户查看自身余额
    function viewBalance() public view returns(uint) {
        return balances[msg.sender];
    }


    //当有用户取出存款后更新存款金额前三
    function recalculateTopThree() private {
        /*遇到问题：添加userWithdraw()这个功能后，如果有存款金额排名前三的用户取出存款则需要更新存款前三的数组。
      更新前三数组则需要用for循环遍历所有用户，就会出现上课讲到的for循环那种经典bug
      */
    }

}

