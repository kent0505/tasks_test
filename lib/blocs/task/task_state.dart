part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoaded extends TaskState {
  TaskLoaded({
    required this.tasks,
    this.filter = 'All',
    this.search = false,
  });

  final List<Task> tasks;
  final String filter;
  final bool search;
}
