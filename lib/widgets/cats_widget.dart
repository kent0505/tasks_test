import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import '../core/hive.dart';
import '../models/cat.dart';
import 'button.dart';
import 'cat_card.dart';
import 'create_category_dialog.dart';
import 'svg_widget.dart';

class CatsWidget extends StatelessWidget {
  const CatsWidget({
    super.key,
    required this.cat,
    required this.onPressed,
  });

  final Cat cat;
  final void Function(Cat) onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            cats.length,
            (index) {
              return CatCard(
                cat: cats[index],
                current: cat,
                onPressed: onPressed,
              );
            },
          )..add(const _CreateCatButton()),
        );
      },
    );
  }
}

class _CreateCatButton extends StatelessWidget {
  const _CreateCatButton();

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const CreateCategoryDialog();
          },
        );
      },
      minSize: 36,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.tertiary2,
          borderRadius: BorderRadius.circular(36),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget(
              'assets/add.svg',
              color: AppColors.white,
            ),
            SizedBox(width: 4),
            Text(
              'Create New',
              style: TextStyle(
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
