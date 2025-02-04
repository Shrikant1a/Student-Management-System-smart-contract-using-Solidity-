// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StudentManagement {
    //struct of student details

    struct Student {
        string name;
        uint256 age;
        uint256 score;
    }

    //mapping
    mapping(uint256 => Student) public students;

    //Arrays
    uint256[] public student_IDS;

    //modifier
    modifier studentExists(uint256 _id) {
        require(students[_id].age != 0, "student does not exist");
        _;
    }
    //Event

    event StudentAdded(uint256 indexed id, string name);
    event StudentScoreUpdate(uint256 indexed id, uint256 score);

    //functions  adding
    function AddedStudent(
        uint256 id,
        string memory name,
        uint256 age,
        uint256 score
    ) public {
        students[id] = Student(name, age, score);
        student_IDS.push(id);
        require(bytes(name).length > 0, "Name cannot be empty");

        require(students[id].age > 0, "Student not found");
        emit StudentAdded(id, name);
    }

    //retrive function
   function getStudent(uint256 id) public view returns ( string memory name, uint256 age, uint256 score) {
        Student storage student = students[id];
        return (student.name, student.age, student.score);
    }
    //update sccore
    // Function to update a student's score
    function updateStudentScore(uint256 id, uint256 newScore)
        public
        studentExists(id)
    {
        students[id].score = newScore;

        emit StudentScoreUpdate(id,newScore);
    }
}
