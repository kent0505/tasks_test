import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import 'button.dart';
import 'check_widget.dart';

class RemindButton extends StatelessWidget {
  const RemindButton({
    super.key,
    required this.active,
    required this.onPressed,
  });

  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            CheckWidget(
              active: active,
              onPressed: null,
            ),
            const SizedBox(width: 8),
            const Text(
              'Remind me',
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
