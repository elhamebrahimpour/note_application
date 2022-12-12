import 'package:hive/hive.dart';
import 'package:note_application/data/model/task.dart';
import 'package:note_application/data/model/task_type.dart';
import 'package:note_application/data/model/task_type_enum.dart';

List<TaskType> getTaskTypeList() {
  var taskList = [
    TaskType(
        image: 'hard_working.png',
        title: 'کار سخت',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'workout.png',
        title: 'بسکتبال',
        taskTypeEnum: TaskTypeEnum.excercise),
    TaskType(
        image: 'meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.meditation),
    TaskType(
        image: 'work_meeting.png',
        title: 'قرار کاری',
        taskTypeEnum: TaskTypeEnum.focus),
  ];
  return taskList;
}
