import '../model/class.dart';
import '../model/student.dart';

class StudentManagementController {
  final List<Student> _students = [
    Student(
      surName: 'New',
      name: "John Doe",
      yearOfBirth: 2003,
      gender: "Male",
    ),
    Student(
        surName: 'New',
        name: "Jane Smith",
        yearOfBirth: 2002,
        gender: "Female"),
    Student(
      surName: 'New',
      name: "Bob Johnson",
      yearOfBirth: 2004,
      gender: "Male",
    ),
    Student(
        surName: 'New',
        name: "Mary Jones",
        yearOfBirth: 2003,
        gender: "Female"),
  ];

  final List<Class> _classes = [
    Class(block: "10", className: "A", students: [
      Student(
        surName: 'New',
        name: "John Doe",
        yearOfBirth: 2003,
        gender: "Male",
      ),
      Student(
          surName: 'New',
          name: "Jane Smith",
          yearOfBirth: 2002,
          gender: "Female"),
      Student(
        surName: 'New',
        name: "Bob Johnson",
        yearOfBirth: 2004,
        gender: "Male",
      ),
    ]),
    Class(block: "10", className: "B", students: [
      Student(
        surName: 'Hoa',
        name: "John Doe",
        yearOfBirth: 2003,
        gender: "Male",
      ),
      Student(
          surName: 'New',
          name: "Jane Smith",
          yearOfBirth: 2002,
          gender: "Female"),
      Student(
        surName: 'Old',
        name: "Bob Johnson",
        yearOfBirth: 2004,
        gender: "Male",
      ),
    ]),
    Class(block: "10", className: "C", students: []),
    Class(block: "11", className: "A", students: []),
    Class(block: "11", className: "B", students: []),
    Class(block: "11", className: "C", students: []),
    Class(block: "12", className: "A", students: []),
    Class(block: "12", className: "B", students: []),
    Class(block: "12", className: "C", students: []),
  ];

  List<Student> get students => _students;
  List<Class> get classes => _classes;

  void addStudent(Student student) {
    _students.add(student);
  }

  void deleteStudentFromToClass(Student student) {
    // _students.remove(student);

    for (Class c in _classes) {
      c.students.remove(student);
    }
  }

  void editStudent(Student oldStudent, Student newStudent) {
    // int index = _students.indexOf(oldStudent);
    // _students[index] = newStudent;

    for (Class c in _classes) {
      int studentIndex = c.students.indexOf(oldStudent);
      if (studentIndex != -1) {
        c.students[studentIndex] = newStudent;
      }
    }
  }

  List<Student> searchStudent(String name) {
    return _students
        .where((student) =>
            student.fullName().toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  // Sort students by name
  void sortStudentsByName() {
    _students.sort((a, b) => a.name.compareTo(b.name));
  }

  // Sort classes by block and class name
  void sortClassesByBlockAndName() {
    _classes.sort((a, b) {
      if (a.block != b.block) {
        return a.block.compareTo(b.block);
      } else {
        return a.className.compareTo(b.className);
      }
    });
  }
}
