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

class SearchTasks extends TaskEvent {
  SearchTasks({this.text = ''});

  final String text;
}

class ExitSearch extends TaskEvent {}

class CreateCat extends TaskEvent {
  CreateCat({required this.cat});

  final Cat cat;
}
