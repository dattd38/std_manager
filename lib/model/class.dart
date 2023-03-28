import 'student.dart';

class Class {
  String block;
  String className;
  List<Student> students;
  bool isExpanded;

  Class({
    required this.block,
    required this.className,
    required this.students,
    this.isExpanded = false,
  });
}
