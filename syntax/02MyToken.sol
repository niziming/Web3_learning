// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyToken {
    string public name = "MyToken";
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    uint256 public count; // 复用现有的计数器

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Increment(address user, uint256 value); // 复用现有的事件

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    // 保留原有的 increment 方法（可选）
    function increment() public {
        count += 1;
        emit Increment(msg.sender, 1);
    }

    // 修改 transfer 方法，集成计数器
    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance.");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        increment();
        return true;
    }
}