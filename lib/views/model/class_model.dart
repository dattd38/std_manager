import 'student_model.dart';

class Class {
  String block;
  String className;
  List<Student> students;
  bool isExpanded;

  List<Student> filterStudent(String name) {
    return students
        .where((student) =>
            student.fullName().toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Class({
    required this.block,
    required this.className,
    required this.students,
    this.isExpanded = false,
  });
}
