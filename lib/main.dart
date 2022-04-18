import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/logic/search/search_bloc.dart';
import 'package:student_management/logic/student/student_cubit.dart';
import 'package:student_management/pages/splash_screen.dart';
import 'package:student_management/student_database.dart';
import 'logic/icon/icon_cubit.dart';
import 'model/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('box_name');
  runApp( StudentManagement(searchBloc: SearchBloc(),iconCubit: IconCubit(),));
}

class StudentManagement extends StatelessWidget {
  final SearchBloc searchBloc;
  final IconCubit iconCubit;
  const StudentManagement({Key? key, required this.searchBloc,required this.iconCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                StudentCubit(list: StudentDatabase().getStudentList(), searchBloc: searchBloc)),
        BlocProvider(create: (context) => iconCubit),
        BlocProvider(create: (context)=>searchBloc),
      ],
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
