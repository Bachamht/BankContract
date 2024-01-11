// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

/*
• 编写一个 BigBank 合约,要求:

• 仅 >0.001 ether(用modifier权限控制)可以存款

• 把管理员转移给 Ownable 合约,只有 Ownable 可以调用

BigBank 的withdraw().

*/

import './bank.sol';
contract BigBank is Bank {
    
    error AmountNotEnough(uint amount);
    error NotContractAddress(address Ownable);
    uint constant MINDEPOSIT = 0.001 ether;

    modifier amountCheck(uint amount) {
        if(amount <= MINDEPOSIT ) revert AmountNotEnough(amount);
        _;
    }

  
    //用户存款
    function deposit() internal amountCheck(msg.value) override {
        balances[msg.sender] = msg.value;
    }

    //向合约授予管理员权限
    function grantPermission(address Ownable) public onlyOwner{
        if(isContract(Ownable) == false) {
            revert NotContractAddress(Ownable);
        }
        administrator = Ownable;
    }
    
    //合约地址与外部地址判断
    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
         return size > 0;
    }

}
