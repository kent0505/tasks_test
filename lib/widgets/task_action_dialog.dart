import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import '../models/task.dart';
import '../pages/edit_task_page.dart';
import 'button.dart';

class TaskActionDialog extends StatelessWidget {
  const TaskActionDialog({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 7,
      ).copyWith(bottom: 34),
      child: SizedBox(
        height: 154 + 8 + 56,
        child: Column(
          children: [
            Container(
              height: 154,
              decoration: BoxDecoration(
                color: AppColors.dialog1,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Select option',
                    style: TextStyle(
                      color: AppColors.text2,
                      fontSize: 13,
                      fontFamily: 'w700',
                    ),
                  ),
                  const SizedBox(height: 11),
                  Container(
                    height: 0.5,
                    color: const Color(0xff545458).withValues(alpha: 0.65),
                  ),
                  SizedBox(
                    height: 56,
                    child: Button(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditTaskPage(task: task);
                            },
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Edit task',
                          style: TextStyle(
                            color: AppColors.dialog2,
                            fontSize: 17,
                            fontFamily: 'w500',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: const Color(0xff545458).withValues(alpha: 0.65),
                  ),
                  SizedBox(
                    height: 56,
                    child: Button(
                      onPressed: () {
                        context.read<TaskBloc>().add(DeleteTask(task: task));
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'Delete task',
                          style: TextStyle(
                            color: AppColors.dialog3,
                            fontSize: 17,
                            fontFamily: 'w500',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.dialog1,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Button(
                onPressed: Navigator.of(context).pop,
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.dialog2,
                      fontSize: 17,
                      fontFamily: 'w700',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
