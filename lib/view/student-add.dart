import 'package:flutter/material.dart';

import '../model/student.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  final surNameController = TextEditingController();
  final nameController = TextEditingController();
  final yearOfBirthController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: surNameController,
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a surname';
                  }
                  return null;
                },
              ),
              //name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              //year of birth
              TextFormField(
                controller: yearOfBirthController,
                decoration: const InputDecoration(labelText: 'Year of Birth'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year of birth';
                  }
                  return null;
                },
              ),
              //gender
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              var newStudent = Student(
                surName: surNameController.text,
                name: nameController.text,
                yearOfBirth: int.parse(yearOfBirthController.text),
                gender: genderController.text,
              );
              Navigator.pop(context, newStudent);
            }
          }),
    );
  }
}
