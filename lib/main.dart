import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/bloc/student_cubit.dart';
import 'package:student_management/pages/splash_screen.dart';
import 'package:student_management/student_database.dart';
import 'model/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('box_name');
  runApp(const StudentManagement());
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentCubit>(
      create: (context) => StudentCubit(list: StudentDatabase().getStudentList()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          iconTheme: const IconThemeData(color: Colors.brown),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
