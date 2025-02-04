import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/app_colors.dart';
import '../core/prefs.dart';
import '../widgets/button.dart';
import '../widgets/page_title.dart';
import '../widgets/svg_widget.dart';

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
              children: const [
                Text(
                  'Pick a time to receive a task notification. You can modify this setting in Settings later.',
                  style: TextStyle(
                    color: AppColors.text1,
                    fontSize: 14,
                    fontFamily: 'w500',
                  ),
                ),
                SizedBox(height: 27),
                _Tile(
                  title: 'None',
                  minute: 100,
                ),
                _Tile(
                  title: 'At the same time',
                  minute: 0,
                ),
                _Tile(
                  title: '5 minutes before',
                  minute: 5,
                ),
                _Tile(
                  title: '10 minutes before',
                  minute: 10,
                ),
                _Tile(
                  title: '15 minutes before',
                  minute: 15,
                ),
                _Tile(
                  title: '30 minutes before',
                  minute: 30,
                ),
                _Tile(
                  title: '1 hour before',
                  minute: 60,
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
    required this.minute,
  });

  final String title;
  final int minute;

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
        onPressed: () async {
          context.read<TaskBloc>().add(SetNotifications(minute: minute));
        },
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
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: minute == notifyMinute
                        ? AppColors.accent
                        : Colors.transparent,
                    border: Border.all(
                      width: 2,
                      color: minute == notifyMinute
                          ? AppColors.accent
                          : AppColors.tertiary2,
                    ),
                  ),
                  child: minute == notifyMinute
                      ? const Center(
                          child: SvgWidget('assets/check.svg'),
                        )
                      : null,
                );
              },
            ),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }
}
