// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TaskChain {
    struct Task {
        uint256 id;
        string title;
        string description;
        bool isCompleted;
        address creator;
    }

    uint256 public taskCount = 0;
    mapping(uint256 => Task) public tasks;

    // Event to notify frontend of new task creation
    event TaskCreated(uint256 id, string title, string description, address creator);
    
    // Event to notify frontend of task completion
    event TaskCompleted(uint256 id, bool isCompleted);

    // Create a new task
    function createTask(string memory _title, string memory _description) public {
        tasks[taskCount] = Task(taskCount, _title, _description, false, msg.sender);
        emit TaskCreated(taskCount, _title, _description, msg.sender);
        taskCount++;
    }

    // Mark task as completed
    function completeTask(uint256 _id) public {
        require(_id < taskCount, "Task does not exist.");
        require(tasks[_id].creator == msg.sender, "Only the creator can complete the task.");

        tasks[_id].isCompleted = true;
        emit TaskCompleted(_id, true);
    }

    // Get task details
    function getTask(uint256 _id) public view returns (Task memory) {
        require(_id < taskCount, "Task does not exist.");
        return tasks[_id];
    }

    // Get all tasks
    function getAllTasks() public view returns (Task[] memory) {
        Task[] memory allTasks = new Task[](taskCount);
        for (uint256 i = 0; i < taskCount; i++) {
            allTasks[i] = tasks[i];
        }
        return allTasks;
    }
}
