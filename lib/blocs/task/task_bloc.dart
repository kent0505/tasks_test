import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/db/hive.dart';
import '../../core/models/cat.dart';
import '../../core/models/task.dart';
import '../../core/utils.dart';

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
        if (task.id == event.task.id) {
          task.title = event.task.title;
          task.cat = event.task.cat;
          task.date = event.task.date;
          task.startTime = event.task.startTime;
          task.endTime = event.task.endTime;
          task.remind = event.task.remind;
        }
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

    on<SearchTasks>((event, emit) async {
      logger('SEARCH TASK EVENT');
      List<Task> searched = event.text.isEmpty
          ? []
          : tasks.where((task) {
              return task.title
                  .toLowerCase()
                  .contains(event.text.toLowerCase());
            }).toList();
      emit(TaskLoaded(
        tasks: searched,
        search: true,
      ));
    });

    on<ExitSearch>((event, emit) async {
      emit(TaskLoaded(tasks: tasks));
    });

    on<CreateCat>((event, emit) async {
      cats.insert(0, event.cat);
      await updateTasks();
      emit(TaskLoaded(tasks: tasks));
    });
  }
}
