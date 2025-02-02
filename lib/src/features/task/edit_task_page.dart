import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/task_bloc.dart';
import '../../core/config/app_colors.dart';
import '../../core/models/subtask.dart';
import '../../core/models/task.dart';
import '../../core/utils.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/check_widget.dart';
import '../../core/widgets/page_title.dart';
import '../../core/widgets/svg_widget.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  List<Subtask> subtasks = [];

  void onSubtaskDone(Subtask value) {
    setState(() {
      for (Subtask subtask in subtasks) {
        if (subtask.id == value.id) subtask.done = !subtask.done;
      }
    });
  }

  void onEdit() {
    context.read<TaskBloc>().add(
          EditTask(
            task: Task(
              id: widget.task.id,
              title: widget.task.title,
              subtasks: subtasks,
              categoryId: widget.task.categoryId,
              date: widget.task.date,
              startTime: widget.task.startTime,
              endTime: widget.task.endTime,
              remind: widget.task.remind,
              done: widget.task.done,
            ),
          ),
        );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    subtasks = widget.task.subtasks.map((e) => Subtask.from(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageTitle(
            title: 'Task Details',
            active: true,
            buttonTitle: 'Edit',
            onPressed: onEdit,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              children: [
                Text(
                  widget.task.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontFamily: 'w700',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.task.date,
                  style: const TextStyle(
                    color: AppColors.text1,
                    fontSize: 14,
                    fontFamily: 'w500',
                  ),
                ),
                const SizedBox(height: 12),
                _Category(task: widget.task),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Time(time: widget.task.startTime),
                    const SizedBox(width: 8),
                    _Time(time: widget.task.endTime),
                  ],
                ),
                const SizedBox(height: 12),
                _Subtasks(
                  subtasks: subtasks,
                  onPressed: onSubtaskDone,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Selected category',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontFamily: 'w700',
            ),
          ),
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.tertiary2,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              width: 1.5,
              color: AppColors.accent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgWidget(
                'assets/cat/cat${task.categoryId}.svg',
              ),
              const SizedBox(width: 4),
              Text(
                getCategory(task.categoryId),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontFamily: 'w700',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.tertiary1,
          borderRadius: BorderRadius.circular(52),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              time,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Subtasks extends StatelessWidget {
  const _Subtasks({
    required this.onPressed,
    required this.subtasks,
  });

  final void Function(Subtask) onPressed;
  final List<Subtask> subtasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: AppColors.tertiary1,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: List.generate(
          subtasks.length,
          (index) {
            return Button(
              onPressed: () {
                onPressed(subtasks[index]);
              },
              child: Container(
                height: 44,
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    CheckWidget(
                      active: subtasks[index].done,
                      onPressed: null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        subtasks[index].title,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontFamily: 'w700',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
