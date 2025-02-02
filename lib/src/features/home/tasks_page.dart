import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/task_bloc.dart';
import '../../core/config/app_colors.dart';
import '../../core/models/task.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/check_widget.dart';
import '../../core/widgets/svg_widget.dart';
import '../../core/widgets/txt_field.dart';
import '../task/edit_task_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8 + MediaQuery.of(context).viewPadding.top),
        TxtField(
          controller: controller,
          hintText: 'Search task',
          prefix: true,
          onChanged: () {},
        ),
        Expanded(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoaded) {
                if (state.tasks.isEmpty) return const _NoData();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return _TaskCard(task: state.tasks[index]);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (task.categoryId != 0)
                      SvgWidget('assets/cat/cat${task.categoryId}.svg'),
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
          Button(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _Dialog(task);
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

class _Dialog extends StatelessWidget {
  const _Dialog(this.task);

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

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Here is empty...',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontFamily: 'w700',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'You don’t have any tasks for this day yet. Click the plus button to create one now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text1,
              fontSize: 14,
              fontFamily: 'w500',
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
