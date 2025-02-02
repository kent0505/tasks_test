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

class DeleteTask extends TaskEvent {
  DeleteTask({required this.task});

  final Task task;
}

class FilterTasks extends TaskEvent {
  FilterTasks({required this.text});

  final String text;
}
