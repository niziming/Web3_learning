// Solidity 核心语法速览

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;  // 指定编译器版本

contract MyToken {
    // 状态变量（存储在 Storage，永久保存，写入贵！）
    string public name = "MyToken";
    uint256 public totalSupply;
    uint public count;

    event Increment(address user, uint value);

    // mapping：类似 Java 的 HashMap<address, uint256>
    mapping(address => uint256) public balanceOf;
    
    // 事件：写入日志，比写 Storage 便宜 10 倍
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // constructor：只在部署时执行一次
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;  // msg.sender = 部署者地址
    }
    
    // 函数权限修饰符
    // public   = 外部和内部都能调用
    // private  = 只有合约内部
    // internal = 合约内部 + 继承合约
    // external = 只有外部调用
    // view     = 不修改状态（免费 call，不消耗 Gas）
    // pure     = 不读不写状态
    
    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);  // 发出事件，记录日志
        return true;
    }

    
    function increment() public {
        count++;
        emit Increment(msg.sender, count);
    }

}