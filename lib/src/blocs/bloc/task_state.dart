part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoaded extends TaskState {
  TaskLoaded({required this.tasks});

  final List<Task> tasks;
}
