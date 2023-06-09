import 'package:flutter/material.dart';

import '../model/student_model.dart';

class EditStudentView extends StatefulWidget {
  final Student student;

  const EditStudentView({super.key, required this.student});

  @override
  _EditStudentViewState createState() => _EditStudentViewState();
}

class _EditStudentViewState extends State<EditStudentView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _surNameController;
  late TextEditingController _nameController;
  late TextEditingController _yearOfBirthController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _surNameController = TextEditingController(text: widget.student.surName);
    _nameController = TextEditingController(text: widget.student.name);
    _yearOfBirthController =
        TextEditingController(text: widget.student.yearOfBirth.toString());
    _genderController = TextEditingController(text: widget.student.gender);
  }

  // _EditStudentState(this.fullNameController, this.yearOfBirthController,
  //     this.genderController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //surName
              TextFormField(
                controller: _surNameController,
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a surname';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
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
                controller: _yearOfBirthController,
                decoration: const InputDecoration(labelText: 'Year of Birth'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year of birth';
                  }
                  return null;
                },
              ),
              //gender
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var newStudent = Student(
              surName: _surNameController.text,
              name: _nameController.text,
              yearOfBirth: int.parse(_yearOfBirthController.text),
              gender: _genderController.text,
            );
            Navigator.pop(context, newStudent);
          }
        },
      ),
    );
  }
}
