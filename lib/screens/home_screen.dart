import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/custom_widgets/task_widget.dart';
import 'package:note_application/model/task.dart';
import 'package:note_application/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //get box to put data in it
  var taskBox = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              //get taskbox lenght from hive db
              itemCount: taskBox.values.length,
              itemBuilder: ((context, index) {
                var task = taskBox.values.toList()[index];
                return TaskWidget(
                  task: task,
                );
              }),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => AddTaskSreen()),
                  ),
                ),
                backgroundColor: greenColor,
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}