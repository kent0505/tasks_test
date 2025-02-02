import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontFamily: 'w700',
      ),
    );
  }
}
