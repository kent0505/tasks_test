import 'package:flutter/material.dart';

import '../../core/config/app_colors.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/page_title.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageTitle(title: 'Control Notifications'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              children: [
                const Text(
                  'Pick a time to receive a task notification. You can modify this setting in Settings later.',
                  style: TextStyle(
                    color: AppColors.text1,
                    fontSize: 14,
                    fontFamily: 'w500',
                  ),
                ),
                const SizedBox(height: 27),
                _Tile(
                  title: 'None',
                  onPressed: () {},
                ),
                _Tile(
                  title: 'At the same time',
                  onPressed: () {},
                ),
                _Tile(
                  title: '5 minutes before',
                  onPressed: () {},
                ),
                _Tile(
                  title: '10 minutes before',
                  onPressed: () {},
                ),
                _Tile(
                  title: '15 minutes before',
                  onPressed: () {},
                ),
                _Tile(
                  title: '30 minutes before',
                  onPressed: () {},
                ),
                _Tile(
                  title: '1 hour before',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.tertiary1,
        borderRadius: BorderRadius.circular(52),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
            const Spacer(),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: AppColors.tertiary2,
                ),
              ),
            ),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }
}
