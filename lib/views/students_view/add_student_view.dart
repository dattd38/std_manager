import 'package:flutter/material.dart';

import '../../tools/constants.dart';
import '../model/class_model.dart';
import '../model/student_model.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  _AddStudentViewState createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  final _formKey = GlobalKey<FormState>();
  final _surNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _yearOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              //name
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
              ),
              Row(
                children: [
                  const Text(
                    'Block',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: Constants.dropDownBlock,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: Constants.block.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        Constants.dropDownBlock = newValue!;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  const Text(
                    'ClassName',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: Constants.dropDownClassName,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: Constants.className.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        Constants.dropDownClassName = newValue!;
                      });
                    },
                  )
                ],
              ),
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
              var newClass = Class(
                  block: Constants.dropDownBlock,
                  className: Constants.dropDownClassName,
                  students: [newStudent]);

              Navigator.pop(context, newClass);
            }
          }),
    );
  }
}
