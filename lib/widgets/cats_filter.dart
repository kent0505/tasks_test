import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import 'button.dart';

class CatsFilter extends StatelessWidget {
  const CatsFilter({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        context.read<TaskBloc>().add(FilterByCats(title: title));
      },
      minSize: 36,
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.tertiary1,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                width: 1.5,
                color: state is TaskLoaded && state.filter == title
                    ? AppColors.accent
                    : Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontFamily: 'w700',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
