// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../view_model/student_view_model.dart';
import '../model/class_model.dart';
import '../model/student_model.dart';
import 'add_student_view.dart';
import 'edit_student_view.dart';

class ListStudentView extends StatefulWidget {
  const ListStudentView({super.key});

  @override
  _ListStudentViewState createState() => _ListStudentViewState();
}

class _ListStudentViewState extends State<ListStudentView> {
  final StudentViewModel _controller = StudentViewModel();
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
          child: Column(
            children: [
              TextField(
                controller: _search,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: _getListSliver(),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Class? newClass = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentView(),
            ),
          );
          if (newClass != null) {
            setState(() {
              _controller.addStudentToClass(newClass);
              _controller.sortStudentsByName();
            });
          }
        },
      ),
    );
  }

  List<Widget> _getListSliver() {
    List<Widget> listSliver = [];
    for (var element in _controller.classes) {
      listSliver.add(
        SliverToBoxAdapter(
          child: ListTile(
            textColor: element.isExpanded ? Colors.blue : Colors.red,
            title: Text(element.block + element.className),
            onTap: () => setState(() {
              if (!element.isExpanded) {
                element.isExpanded = true;
              } else {
                element.isExpanded = false;
              }
            }),
            trailing: Icon(
              (element.isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded),
            ),
          ),
        ),
      );

      if (element.isExpanded) {
        listSliver.add(
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                textColor: Colors.blue,
                title:
                    Text(element.filterStudent(_search.text)[index].fullName()),
                subtitle: Text(
                  "Year of birth: ${element.filterStudent(_search.text)[index].yearOfBirth}, Gender: ${element.filterStudent(_search.text)[index].gender}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Student? editStudent = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStudentView(
                              student: element.students[index],
                            ),
                          ),
                        );
                        if (editStudent != null) {
                          setState(() {
                            _controller.editStudent(
                                element.filterStudent(_search.text)[index],
                                editStudent);
                          });
                        }
                        ;
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.removeStudentFromClass(
                              element.filterStudent(_search.text)[index]);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              ),
              childCount: element.filterStudent(_search.text).length,
            ),
          ),
        );
      }
    }
    return listSliver;
  }
}
