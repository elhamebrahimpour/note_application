import 'package:hive/hive.dart';
import 'package:note_application/data/model/task_priority.dart';
import 'package:note_application/data/model/task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task(
      {required this.title,
      required this.subTitle,
      this.isDone = false,
      required this.time,
      required this.taskType,
      required this.priority});
  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  TaskType taskType;
  @HiveField(5)
  Priority priority;
}

//hive object has two method -save and delete- which can be useful to update and change a task object in database
