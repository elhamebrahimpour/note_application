import 'package:hive/hive.dart';

part 'task_priority.g.dart';

@HiveType(typeId: 4)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}
