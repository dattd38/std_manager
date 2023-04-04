import '../model/class_model.dart';
import '../model/student_model.dart';

class StudentViewModel {
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
  //get list class
  List<Class> get classes => _classes;
  // get block class
  List<String> getBlock() {
    List<String>? block = [];
    for (Class c in _classes) {
      block.add(c.block);
    }
    return block;
  }

  //get className
  List<String> getClassName() {
    List<String>? className = [];
    for (Class c in _classes) {
      className.add(c.className);
    }
    return className;
  }

  // add student to class
  void addStudentToClass(Class classes) {
    for (Class c in _classes) {
      if (c.block == classes.block && c.className == classes.className) {
        c.students.add(classes.students.first);
      }
    }
  }

  //remove student from Class
  void removeStudentFromClass(Student student) {
    for (Class c in _classes) {
      c.students.remove(student);
    }
  }

  //edit information student
  void editStudent(Student oldStudent, Student newStudent) {
    for (Class c in _classes) {
      int studentIndex = c.students.indexOf(oldStudent);
      if (studentIndex != -1) {
        c.students[studentIndex] = newStudent;
      }
    }
  }

  //search student by fullName
  List<Class> searchStudentsByFullName(String name) {
    List<Class> classesWithStudent = [];

    for (Class c in _classes) {
      List<Student> studentsWithName = c.students
          .where((student) =>
              student.fullName().toLowerCase().contains(name.toLowerCase()))
          .toList();

      if (studentsWithName.isNotEmpty) {
        classesWithStudent.add(c);
      }
    }

    return classesWithStudent;
  }

  // Sort students by name
  void sortStudentsByName() {
    for (Class c in _classes) {
      c.students.sort((a, b) => a.name.compareTo(b.name));
    }
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
