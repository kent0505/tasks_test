import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/db/hive.dart';
import '../../core/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetTask>((event, emit) async {
      await getTasks();
      await Future.delayed(const Duration(seconds: 2));
      emit(TaskLoaded(tasks: tasks));
    });

    on<AddTask>((event, emit) async {
      tasks.insert(0, event.task);
      await updateTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<EditTask>((event, emit) async {
      for (Task task in tasks) {
        if (task.id == event.task.id) task.subtasks = event.task.subtasks;
      }
      await updateTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<DeleteTask>((event, emit) async {
      tasks.removeWhere((task) => task.id == event.task.id);
      await updateTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<DoneTask>((event, emit) async {
      for (Task task in tasks) {
        if (task.id == event.task.id) task.done = !task.done;
      }
      await updateTasks();
      emit(TaskLoaded(tasks: tasks));
    });
  }
}
