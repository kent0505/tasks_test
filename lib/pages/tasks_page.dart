import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import '../widgets/button.dart';
import '../widgets/no_data.dart';
import '../widgets/svg_widget.dart';
import '../widgets/task_card.dart';
import '../widgets/txt_field.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8 + MediaQuery.of(context).viewPadding.top),
        const _Search(),
        const SizedBox(height: 16),
        const _SearchedAmount(),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoaded) {
                if (state.tasks.isEmpty) return const NoData();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: state.tasks[index]);
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

class _Search extends StatefulWidget {
  const _Search();

  @override
  State<_Search> createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Row(
          children: [
            const SizedBox(width: 16),
            if (state is TaskLoaded && state.search) ...[
              Button(
                onPressed: () {
                  controller.clear();
                  context.read<TaskBloc>().add(ExitSearch());
                },
                child: const SvgWidget('assets/back.svg'),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: TxtField(
                controller: controller,
                hintText: 'Search task',
                search: true,
                onChanged: () {
                  context
                      .read<TaskBloc>()
                      .add(SearchTasks(text: controller.text));
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        );
      },
    );
  }
}

class _SearchedAmount extends StatelessWidget {
  const _SearchedAmount();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded && state.search) {
          return Row(
            children: [
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Most relevant results',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontFamily: 'w700',
                  ),
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.tertiary1,
                ),
                child: Center(
                  child: Text(
                    state.tasks.length.toString(),
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontFamily: 'w700',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          );
        }

        return Container();
      },
    );
  }
}
