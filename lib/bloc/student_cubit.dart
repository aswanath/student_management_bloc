import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../model/student.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit({required this.list}) : super(StudentInitial()){
    emit(LoadedListState(studentList: list));
  }
 final List<Student> list;
  void addStudentListUpdated(Box<Student> box) {
    emit(AddListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }

  void editStudentListUpdated(Box<Student> box) {
    emit(EditListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }

  void deleteStudentListUpdated(Box<Student> box) {
    emit(DeleteListState());
    emit(LoadedListState(studentList: box.values.toList()));
  }
}
