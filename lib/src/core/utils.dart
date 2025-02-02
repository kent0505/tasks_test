import 'dart:developer' as developer;

import 'package:intl/intl.dart';

import 'db/hive.dart';
import 'models/category.dart';

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

String getCategory(int id) {
  for (Category category in categories) {
    if (category.iconId == id) return category.title;
  }
  return '';
}
