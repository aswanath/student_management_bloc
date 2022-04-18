import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_management/student_database.dart';

import '../../model/student.dart';
import '../search/search_bloc.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final List<Student> list;

  //initial emit
  StudentCubit({required this.list}) : super(StudentInitial()){
    emit(LoadedListState(studentList: list));
  }

  //add list emit
  void addStudentListUpdated(Box<Student> box) {
    print("add List state");
    emit(AddListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }

  //edit list emit
  void editStudentListUpdated(Box<Student> box) {
    print("edit List state");
    emit(EditListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }

  //delete list emit
  void deleteStudentListUpdated(Box<Student> box) {
    print("delete List state");
    emit(DeleteListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }


}

