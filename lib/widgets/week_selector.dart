import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/app_colors.dart';

class WeekSelector extends StatefulWidget {
  const WeekSelector({super.key});

  @override
  State<WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<WeekSelector> {
  late DateTime _monday;

  DateTime _getMonday(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _changeWeek(int offset) {
    setState(() {
      _monday = _monday.add(Duration(days: 7 * offset));
    });
  }

  @override
  void initState() {
    super.initState();
    _monday = _getMonday(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = List.generate(
      7,
      (index) => _monday.add(Duration(days: index)),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _changeWeek(-1),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _changeWeek(1),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weekDays.map((date) => _dateBox(date)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _dateBox(DateTime date) {
    return Column(
      children: [
        Text(
          DateFormat('EEE').format(date),
          style: const TextStyle(
            color: AppColors.text2,
            fontSize: 10,
            fontFamily: 'w700',
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: date.day == DateTime.now().day
                ? AppColors.tertiary1
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: date.day == DateTime.now().day
                    ? AppColors.accent
                    : AppColors.white,
                fontSize: 14,
                fontFamily: 'w700',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
