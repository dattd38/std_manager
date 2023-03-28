// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../controller/student-controller.dart';
import '../model/class.dart';
import '../model/student.dart';
import 'student-add.dart';
import 'student-edit.dart';

class StudentManagementPage extends StatefulWidget {
  const StudentManagementPage({super.key});

  @override
  _StudentManagementPageState createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  final StudentManagementController _controller = StudentManagementController();
  final _search = TextEditingController();
  // Sort students by name when the page is created
  @override
  void initState() {
    super.initState();
    _controller.sortStudentsByName();
    _controller.sortClassesByBlockAndName();
  }

  // Build the main page UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("List of Classes", style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 10.0),
            // CustomScrollView(
            //   slivers: [
            //     SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //         (context, index) {
            //           Class currentClass = _controller.classes[index];
            //           return ExpansionPanelList(
            //             expansionCallback: (panelIndex, isExpanded) {
            //               setState(() {
            //                 currentClass.isExpanded = !isExpanded;
            //               });
            //             },
            //             children: [
            //               ExpansionPanel(
            //                 headerBuilder: (context, isExpanded) {
            //                   return ListTile(
            //                     title: Text(
            //                         "Block ${currentClass.block} - Class ${currentClass.className}"),
            //                   );
            //                 },
            //                 body: ListView.builder(
            //                   shrinkWrap: true,
            //                   physics: const NeverScrollableScrollPhysics(),
            //                   itemCount: currentClass.students.length,
            //                   itemBuilder: (BuildContext context, int index) {
            //                     Student student = currentClass.students[index];
            //                     return ListTile(
            //                       title: Text(student.fullName()),
            //                       subtitle: Text(
            //                           "Year of birth: ${student.yearOfBirth}, Gender: ${student.gender}"),
            //                       trailing: Row(
            //                         mainAxisSize: MainAxisSize.min,
            //                         children: [
            //                           IconButton(
            //                             icon: const Icon(Icons.edit),
            //                             onPressed: () async {
            //                               Student? editStudent =
            //                                   await Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                   builder: (context) =>
            //                                       EditStudent(student: student),
            //                                 ),
            //                               );
            //                               if (editStudent != null) {
            //                                 setState(() {
            //                                   _controller.editStudent(
            //                                       student, editStudent);
            //                                 });
            //                               }
            //                             },
            //                           ),
            //                           IconButton(
            //                             icon: const Icon(Icons.delete),
            //                             onPressed: () {
            //                               setState(() {
            //                                 _controller.deleteStudent(student);
            //                               });
            //                             },
            //                           )
            //                         ],
            //                       ),
            //                     );
            //                   },
            //                 ),
            //                 isExpanded: currentClass.isExpanded,
            //               ),
            //             ],
            //           );
            //         },
            //         childCount: _controller.classes.length,
            //       ),
            //     )
            //   ],
            // ),
            TextField(
              controller: _search,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: () {
                setState(() {
                  _controller.sortStudentsByName();
                });
              },
              icon: const Icon(Icons.sort_by_alpha),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _controller.classes.length,
              itemBuilder: (BuildContext context, int index) {
                Class c = _controller.classes[index];
                return ExpansionTile(
                  title: Text("Block ${c.block} - Class ${c.className}"),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: c.students.length,
                      itemBuilder: (BuildContext context, int index) {
                        Student student = c.students[index];
                        return ListTile(
                          title: Text(student.fullName()),
                          subtitle: Text(
                              "Year of birth: ${student.yearOfBirth}, Gender: ${student.gender}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  Student? editStudent = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditStudent(student: student),
                                    ),
                                  );
                                  if (editStudent != null) {
                                    setState(() {
                                      _controller.editStudent(
                                          student, editStudent);
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _controller
                                        .deleteStudentFromToClass(student);
                                    _controller.sortStudentsByName();
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Student? newStudent = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudent(),
            ),
          );
          if (newStudent != null) {
            setState(() {
              _controller.addStudent(newStudent);
              _controller.sortStudentsByName();
            });
          }
        },
      ),
    );
  }
}
