// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract TodoList {
        
    struct Todo {
        string message;
        bool completed;
    }

    mapping(address => Todo[]) private todos;

    event TodoAdded(address indexed user, string message);
    event TodoCompleted(address indexed user, uint256 index);
    event TodoEdited(address indexed user, uint256 index, string newMessage);
    event TodoDeleted(address indexed user, uint256 index);

    function getTodos() public view returns (Todo[] memory) {
        return todos[msg.sender];
    }

    function addTodo(string memory message) public {
        todos[msg.sender].push(Todo(message, false));
        emit TodoAdded(msg.sender, message);
    }

    function completeTodo(uint256 index) public {
        require(index < todos[msg.sender].length, "Index out of bounds");
        todos[msg.sender][index].completed = true;
        emit TodoCompleted(msg.sender, index);
    }

    function editTodo(uint256 index, string memory newMessage) public {
        require(index < todos[msg.sender].length, "Index out of bounds");
        todos[msg.sender][index].message = newMessage;
        emit TodoEdited(msg.sender, index, newMessage);
    }

    function deleteTodo(uint256 index) public {
        require(index < todos[msg.sender].length, "Index out of bounds");
        uint256 lastIndex = todos[msg.sender].length - 1;
        todos[msg.sender][index] = todos[msg.sender][lastIndex];
        todos[msg.sender].pop();
        emit TodoDeleted(msg.sender, index);
    }
}