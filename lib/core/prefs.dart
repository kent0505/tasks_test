import 'package:shared_preferences/shared_preferences.dart';

int notifyMinute = 100;

Future<void> getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  notifyMinute = prefs.getInt('notifyMinute') ?? 100;
}

Future<void> saveInt(int value) async {
  final prefs = await SharedPreferences.getInstance();
  notifyMinute = value;
  await prefs.setInt('notifyMinute', notifyMinute);
}
