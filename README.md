# 测试流程

1.账户**A**向银行转入0.0009个SepoliaETH，转入失败

![image]()

2.账户**A**向银行转入**0.3**个SepoliaETH

3.调用**Ownable**合约撤走资产，结果失败

![image](https://github.com/Bachamht/BankContract/blob/main/images/d62b6bdfae62bd1ab1734dd89977dc61.png)

4.调用**grantPermission()**向**Ownable**合约授权

![image](https://github.com/Bachamht/BankContract/blob/main/images/40543354f474e1ddeba8282cda4126bc.png)

5.调用**Ownable**合约向账户**A**授权

6.调用**Ownable**合约，账户**B**撤走银行所有存款,结果失败

7.调用**Ownable**合约，账户**A**撤走银行所有存款

![image]()

