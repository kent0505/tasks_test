import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';
import '../models/subtask.dart';
import '../models/category.dart';

List<Task> tasks = [];
List<Category> categories = [];

const boxName = 'tasks-test-box';

Future<void> getTasks() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk(boxName);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(SubtaskAdapter());
  Hive.registerAdapter(CategoryAdapter());
  final box = await Hive.openBox(boxName);
  List data1 = box.get('tasks') ?? [];
  List data2 = box.get('categories') ?? defaultCategories;
  tasks = data1.cast<Task>();
  categories = data2.cast<Category>();
}

Future<void> updateTasks() async {
  final box = await Hive.openBox(boxName);
  box.put('tasks', tasks);
  tasks = await box.get('tasks');
}
