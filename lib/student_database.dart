import 'package:hive/hive.dart';
import 'model/student.dart';

class StudentDatabase {
  final box = Hive.box<Student>('box_name');

  Box<Student> getStudentBox(){
    final box = this.box;
    return box;
  }

  //get list
  List<Student> getStudentList() {
    final List<Student> studentList = box.values.toList();
    return studentList;
  }

  //create student
  void addStudent(Student student) {
    box.add(student);
  }

  //get a student detail
  Student getStudentDetail(int key){
    Student student = box.get(key)!;
    return student;
  }

  //edit student
  void editStudent(int key, Student student) {
    box.put(key, student);
  }

  //delete student
  void deleteStudent(int key) {
    box.delete(key);
  }
}
