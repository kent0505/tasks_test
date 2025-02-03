import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class SubtaskAddButton extends StatelessWidget {
  const SubtaskAddButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: const SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgWidget('assets/add.svg'),
            SizedBox(width: 10),
            Text(
              'Add sub-tasks',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
