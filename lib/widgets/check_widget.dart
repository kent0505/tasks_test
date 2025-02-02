import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    super.key,
    required this.active,
    required this.onPressed,
  });

  final bool active;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      minSize: 24,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? AppColors.accent : null,
          border: active
              ? null
              : Border.all(
                  width: 2,
                  color: AppColors.tertiary2,
                ),
        ),
        child: active
            ? const Center(
                child: SvgWidget('assets/check.svg'),
              )
            : null,
      ),
    );
  }
}
