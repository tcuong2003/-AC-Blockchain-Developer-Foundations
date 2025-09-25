// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistryV2 {
    // --- Struct ---
    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    // --- State ---
    address public owner; // chỉ owner mới được thêm sinh viên
    mapping(address => Student) private students;

    // --- Event ---
    event StudentAdded(address indexed studentAddress, string name, uint age);

    // --- Modifier ---
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // --- Constructor ---
    constructor() {
        owner = msg.sender; // lưu người deploy contract
    }

    // --- Thêm sinh viên (chỉ owner gọi) ---
    function addStudent(address studentAddr, string memory name, uint age) public onlyOwner {
        require(!students[studentAddr].isRegistered, "Student already registered");
        require(age > 0, "Invalid age");

        students[studentAddr] = Student(name, age, true);

        emit StudentAdded(studentAddr, name, age);
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
