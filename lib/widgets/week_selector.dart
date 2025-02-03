import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/hive.dart';
import '../core/utils.dart';
import 'button.dart';
import 'svg_widget.dart';

class WeekSelector extends StatefulWidget {
  const WeekSelector({super.key});

  @override
  State<WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<WeekSelector> {
  DateTime _current = getMondayOfWeek(DateTime.now());

  void _changeWeek(int offset) {
    setState(() {
      _current = _current.add(Duration(days: offset * 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = List.generate(
      7,
      (index) => _current.add(Duration(days: index)),
    );

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            Button(
              onPressed: () => _changeWeek(-1),
              child: const SvgWidget('assets/back.svg'),
            ),
            const Spacer(),
            Text(
              getMonthYear(_current),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
            const SizedBox(width: 10),
            const SvgWidget(
              'assets/calendar.svg',
              color: AppColors.white,
            ),
            const Spacer(),
            Button(
              onPressed: () => _changeWeek(1),
              child: const RotatedBox(
                quarterTurns: 2,
                child: SvgWidget('assets/back.svg'),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Weekday('Mon'),
              _Weekday('Tue'),
              _Weekday('Wed'),
              _Weekday('Thu'),
              _Weekday('Fri'),
              _Weekday('Sat'),
              _Weekday('Sun'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays
                .map((date) => _Day(
                      date: date,
                      current: _current,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _Weekday extends StatelessWidget {
  const _Weekday(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff8A948E),
            fontSize: 10,
            fontFamily: 'w700',
          ),
        ),
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({required this.date, required this.current});

  final DateTime date;
  final DateTime current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 44,
      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday(date) ? AppColors.tertiary1 : Colors.transparent,
            ),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: isToday(date)
                      ? AppColors.accent
                      : date.month == current.month
                          ? AppColors.white
                          : const Color(0xff75799B),
                  fontSize: 16,
                  fontFamily: 'w700',
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasSameDate(tasks, date)
                  ? AppColors.accent
                  : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
