import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final double? width;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 52,
      width: width,
      decoration: BoxDecoration(
        color:
            active ? AppColors.accent : AppColors.accent.withValues(alpha: .6),
        borderRadius: BorderRadius.circular(52),
      ),
      child: Button(
        onPressed: active ? onPressed : null,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.main,
              fontSize: 18,
              fontFamily: 'w700',
            ),
            // fontSize: 16,
            // color: state is ButtonInitial
            //     ? Colors.white
            //     : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
