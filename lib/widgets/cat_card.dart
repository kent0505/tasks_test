import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import '../core/models/cat.dart';
import 'button.dart';
import 'svg_widget.dart';

class CatCard extends StatelessWidget {
  const CatCard({
    super.key,
    required this.cat,
    required this.current,
    required this.onPressed,
  });

  final Cat cat;
  final Cat current;
  final void Function(Cat) onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        onPressed(cat);
      },
      minSize: 36,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.tertiary2,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            width: 1.5,
            color: cat.id == current.id ? AppColors.accent : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget('assets/cat/cat${cat.id}.svg'),
            const SizedBox(width: 4),
            Text(
              cat.title,
              style: const TextStyle(
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
