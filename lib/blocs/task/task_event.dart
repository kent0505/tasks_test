part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class GetTask extends TaskEvent {}

class AddTask extends TaskEvent {
  AddTask({required this.task});
  final Task task;
}

class EditTask extends TaskEvent {
  EditTask({required this.task});
  final Task task;
}

class DoneTask extends TaskEvent {
  DoneTask({required this.task});
  final Task task;
}

class DoneSubtask extends TaskEvent {
  DoneSubtask({
    required this.task,
    required this.subtask,
  });
  final Task task;
  final Subtask subtask;
}

class DeleteTask extends TaskEvent {
  DeleteTask({required this.task});
  final Task task;
}

class SearchTasks extends TaskEvent {
  SearchTasks({this.text = ''});
  final String text;
}

class ExitSearch extends TaskEvent {}

class CreateCat extends TaskEvent {
  CreateCat({required this.cat});
  final Cat cat;
}

class ClearData extends TaskEvent {}

class FilterByCats extends TaskEvent {
  FilterByCats({required this.title});
  final String title;
}
