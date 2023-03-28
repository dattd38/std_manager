class Student {
  String surName;
  String name;
  int yearOfBirth;
  String gender;

  Student({
    required this.surName,
    required this.name,
    required this.yearOfBirth,
    required this.gender,
  });

  String fullName() {
    return '$surName $name';
  }
}
