import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import '../models/task.dart';
import '../pages/task_details_page.dart';
import 'button.dart';
import 'check_widget.dart';
import 'svg_widget.dart';
import 'task_action_dialog.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.tertiary1,
        borderRadius: BorderRadius.circular(76),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          CheckWidget(
            active: task.done,
            onPressed: () {
              context.read<TaskBloc>().add(DoneTask(task: task));
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TaskDetailsPage(task: task);
                    },
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgWidget('assets/cat/cat${task.cat.id}.svg'),
                      const SizedBox(width: 4),
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontFamily: 'w700',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${task.startTime} - ${task.endTime}',
                    style: const TextStyle(
                      color: AppColors.text1,
                      fontSize: 12,
                      fontFamily: 'w500',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Button(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TaskActionDialog(task: task);
                },
              );
            },
            minSize: 40,
            child: const SvgWidget('assets/dots.svg'),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
