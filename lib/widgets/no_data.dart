import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

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
          SizedBox(height: 75),
        ],
      ),
    );
  }
}
