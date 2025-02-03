import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/app_colors.dart';
import '../core/hive.dart';
import '../core/utils.dart';
import 'button.dart';
import 'svg_widget.dart';

class DatePickDialog extends StatefulWidget {
  const DatePickDialog({super.key, required this.date});

  final DateTime date;

  @override
  State<DatePickDialog> createState() => _DatePickDialogState();
}

class _DatePickDialogState extends State<DatePickDialog> {
  DateTime _current = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _current = DateTime(_current.year, _current.month + offset, 1);
    });
  }

  String getMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  List<DateTime> generateMonthDays(DateTime current) {
    final firstDay = DateTime(current.year, current.month, 1);
    int startWeekday = (firstDay.weekday + 6) % 7;
    DateTime firstVisibleDate = firstDay.subtract(Duration(days: startWeekday));
    return List.generate(42, (i) => firstVisibleDate.add(Duration(days: i)));
  }

  List<DateTime> getWeek(DateTime date, int index) {
    return generateMonthDays(date).skip(index * 7).take(7).toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.tertiary1,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Button(
                  onPressed: () => _changeMonth(-1),
                  child: const SvgWidget('assets/back.svg'),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      getMonthYear(_current),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontFamily: 'w700',
                      ),
                    ),
                  ),
                ),
                Button(
                  onPressed: () => _changeMonth(1),
                  child: const RotatedBox(
                    quarterTurns: 2,
                    child: SvgWidget('assets/back.svg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
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
            const SizedBox(height: 12),
            Column(
              children: List.generate(6, (weekIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: getWeek(_current, weekIndex).map((date) {
                      return _Day(
                        date: date,
                        isSelected: date == _selectedDate,
                        isToday: isToday(date),
                        isCurrentMonth: date.month == _current.month,
                        exist: hasSameDate(tasks, date),
                        onPressed: () {
                          setState(() {
                            _selectedDate = date;
                          });
                          Navigator.pop(context, date);
                        },
                      );
                    }).toList(),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.date,
    required this.isCurrentMonth,
    required this.isToday,
    required this.isSelected,
    this.exist = false,
    required this.onPressed,
  });

  final DateTime date;
  final bool isCurrentMonth;
  final bool isToday;
  final bool isSelected;
  final bool exist;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: SizedBox(
        height: 52,
        width: 44,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isToday && isCurrentMonth
                    ? AppColors.accent
                    : isSelected
                        ? Colors.greenAccent.shade400
                        : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isCurrentMonth
                        ? AppColors.white
                        : const Color(0xFF75799B),
                    fontSize: 16,
                    fontFamily: 'w700',
                  ),
                ),
              ),
            ),
            if (exist)
              Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
              ),
          ],
        ),
      ),
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
            color: Color(0xffBCBCBC),
            fontSize: 14,
            fontFamily: 'w500',
          ),
        ),
      ),
    );
  }
}
