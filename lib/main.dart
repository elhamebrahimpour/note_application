import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/model/task.dart';
import 'package:note_application/screens/home_screen.dart';

void main() async {
  //initialize address for saving data
  await Hive.initFlutter();
  //create box and save data in this box in the future
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(
    Application(),
  );
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(
              fontFamily: 'Shabnam',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: blackColor),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
