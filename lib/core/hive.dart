import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';
import '../models/subtask.dart';
import '../models/cat.dart';

List<Task> tasks = [];
List<Cat> cats = [];

const boxName = 'tasks-test-box';

Future<void> getTasks() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk(boxName);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(SubtaskAdapter());
  Hive.registerAdapter(CatAdapter());
  final box = await Hive.openBox(boxName);
  List data1 = box.get('tasks') ?? [];
  List data2 = box.get('cats') ?? defaultCategories;
  tasks = data1.cast<Task>();
  cats = data2.cast<Cat>();
}

Future<void> updateTasks() async {
  final box = await Hive.openBox(boxName);
  box.put('tasks', tasks);
  box.put('cats', cats);
  tasks = await box.get('tasks');
  cats = await box.get('cats');
}
