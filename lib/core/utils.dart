import 'dart:developer' as developer;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import 'hive.dart';
import 'prefs.dart';

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

final notificationPlugin = FlutterLocalNotificationsPlugin();
bool initialized = false;

Future<void> initNotification() async {
  if (initialized) return;
  tz.initializeTimeZones();
  final String currentTimezone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimezone));
  await notificationPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    ),
  );
  initialized = true;
}

NotificationDetails notificationDetails() {
  return const NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Notifications',
      channelDescription: 'Daily notification channel',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );
}

Future<void> showNotification(String title, String body) async {
  await notificationPlugin.show(
    0,
    title,
    body,
    notificationDetails(),
  );
}

Future<void> scheduleNotification(
  int id,
  int day,
  int hour,
  int minute,
) async {
  final now = tz.TZDateTime.now(tz.local);
  final date = tz.TZDateTime(tz.local, now.year, now.month, day, hour, minute);
  await notificationPlugin.zonedSchedule(
    0,
    '!!!',
    'Don’t forget your task',
    date,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

Future<void> setScheduledNotifs() async {
  await notificationPlugin.cancelAll();
  for (Task task in tasks) {
    if (task.remind) {
      final date = stringToDate(task.date);
      await scheduleNotification(
        1,
        date.day,
        date.hour,
        date.minute - notifyMinute,
      );
    }
  }
}
