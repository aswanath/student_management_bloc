import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0)
   String name;

  @HiveField(1)
   int age;

  @HiveField(2)
  int currentClass;

  @HiveField(3)
   String place;

  @HiveField(4)
   dynamic imagePath;

  Student({required this.name, required this.age,required this.currentClass, required this.place,required this.imagePath, });
}