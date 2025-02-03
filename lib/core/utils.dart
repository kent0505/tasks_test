import 'dart:developer' as developer;

import 'package:intl/intl.dart';
import 'package:tasks_test/models/task.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

String timestampToString(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd.MM.yyyy').format(date); // timestamp to 22.06.2000
}

String dateToString(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date); // DateTime to 22.06.2000
}

String timeToString(DateTime time) {
  return DateFormat('HH:mm a').format(time); // DateTime to 22:00
}

void logger(Object message) => developer.log(message.toString());

bool hasSameDate(List<Task> models, DateTime date) {
  try {
    return models.any((model) {
      List<String> parts = model.date.split('.');
      DateTime parsed = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
      return parsed.year == date.year &&
          parsed.month == date.month &&
          parsed.day == date.day;
    });
  } catch (_) {
    return false;
  }
}

bool isToday(DateTime date) {
  DateTime now = DateTime.now();
  return date.day == now.day &&
      date.month == now.month &&
      date.year == now.year;
}

String getMonthYear(DateTime date) {
  return DateFormat('MMMM yyyy').format(date);
}

DateTime getMondayOfWeek(DateTime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

String getWeekRange(DateTime start) {
  DateTime end = start.add(const Duration(days: 6));
  return "${start.day} - ${end.day} ${getMonthName(start)}";
}

String getMonthName(DateTime date) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[date.month - 1];
}
