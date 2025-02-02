part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoaded extends TaskState {
  TaskLoaded({
    required this.tasks,
    this.search = false,
  });

  final List<Task> tasks;
  final bool search;
}
