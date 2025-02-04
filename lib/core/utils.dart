import 'dart:developer' as developer;

import 'package:intl/intl.dart';

import '../models/task.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

String dateToString(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}

String timeToString(DateTime time) {
  return DateFormat('HH:mm a').format(time);
}

DateTime stringToDate(String date) {
  try {
    return DateFormat('dd.MM.yyyy').parseStrict(date);
  } catch (e) {
    return DateTime.now();
  }
}

void logger(Object message) => developer.log(message.toString());

bool hasSameDate(List<Task> models, DateTime date) {
  try {
    return models.any((model) {
      DateTime parsed = stringToDate(model.date);
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
