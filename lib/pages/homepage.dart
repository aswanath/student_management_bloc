import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/logic/search/search_bloc.dart';
import 'package:student_management/logic/student/student_cubit.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/pages/alldetails.dart';
import 'package:student_management/pages/add.dart';
import 'package:student_management/pages/edit.dart';
import 'package:student_management/student_database.dart';
import 'package:student_management/widgets/baseappbar.dart';
import 'dart:io';

import '../logic/icon/icon_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData? cusIcon;
  Widget cusSearchBar = const Text("Student Management");
  String searchtext = "";
  StudentDatabase studentDatabase = StudentDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: PreferredSize(
          child: BlocBuilder<IconCubit, IconState>(builder: (context, state) {
            cusIcon = state.props[0] as IconData;
            return BaseAppBar(
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<IconCubit>().changeICon(cusIcon!);
                    if (cusIcon == Icons.search) {
                      cusSearchBar = TextField(
                        autofocus: true,
                        onChanged: (value) {
                          context.read<SearchBloc>().add(EnterInput(searchInput: value));
                        },
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.tealAccent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.tealAccent)),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.tealAccent,
                            )),
                        style: const TextStyle(
                            color: Colors.tealAccent, fontSize: 20),
                      );
                    } else {
                      context.read<SearchBloc>().add(ClearInput());
                      cusSearchBar = const Text("Student Management");
                    }
                  },
                  icon: Icon(cusIcon),
                )
              ],
              title: cusSearchBar,
            );
          }),
          preferredSize: const Size(double.infinity, 60)),
      body:
          BlocConsumer<StudentCubit, StudentState>(listener: (context, state) {
        String process = '';
        if (state is AddListState) {
          process = 'Added';
        }
        if (state is EditListState) {
          process = 'Edited';
        }
        if (state is DeleteListState) {
          process = 'Deleted';
        }
        if (state is! LoadedListState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Student $process Successfully")));
        }
      }, builder: (context, state) {
        if (state is LoadedListState) {
          if (state.studentList.isEmpty) {
            return const Center(
              child: Text("The Student List is Empty"),
            );
          } else {
                final List<Student> data = state.studentList;
                if (data.isEmpty) {
                  return const Center(
                      child: Text(
                    "No results found",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ));
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: ListTile(
                              visualDensity: const VisualDensity(vertical: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              tileColor: Colors.white,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllDetails(
                                              index: data[index].key,
                                            )));
                              },
                              leading: data[index].imagePath == null
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        "No Image",
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.tealAccent),
                                      ),
                                    )
                                  : CircleAvatar(
                                      child: ClipOval(
                                          child: Image.file(
                                      File(data[index].imagePath),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ))),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Edit(
                                                    itemKey: data[index].key,
                                                  )));
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Do you want to delete it?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No")),
                                                TextButton(
                                                    onPressed: () {
                                                      StudentDatabase().deleteStudent(data[index].key);
                                                      Navigator.pop(context);
                                                      BlocProvider.of<
                                                                  StudentCubit>(
                                                              context)
                                                          .deleteStudentListUpdated(
                                                              StudentDatabase()
                                                                  .getStudentBox());
                                                      context.read<SearchBloc>().add(ClearInput());
                                                    },
                                                    child: const Text("Yes"))
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(
                                data[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.blue[50],
                          );
                        },
                        itemCount: data.length),
                  );
                }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purpleAccent,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Details()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.tealAccent,
          )),
    );
  }
}
