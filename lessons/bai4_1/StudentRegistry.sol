// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistry {
    // --- Struct ---
    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    // --- Mapping lưu thông tin sinh viên ---
    mapping(address => Student) private students;

    // --- Đăng ký sinh viên ---
    function register(string memory name, uint age) public {
        require(!students[msg.sender].isRegistered, "Already registered");
        require(age > 0, "Invalid age");

        students[msg.sender] = Student(name, age, true);
    }

    // --- Lấy thông tin sinh viên ---
    function getStudent(address user) public view returns (string memory, uint, bool) {
        Student memory s = students[user];
        return (s.name, s.age, s.isRegistered);
    }

    // --- Kiểm tra đã đăng ký chưa ---
    function isStudentRegistered(address user) public view returns (bool) {
        return students[user].isRegistered;
    }
}
