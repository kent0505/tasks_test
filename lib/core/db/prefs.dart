import 'package:shared_preferences/shared_preferences.dart';

Future<void> getPrefs() async {
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  // onboard = prefs.getBool('onboard') ?? true;
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<void> saveString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> saveInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> saveStringList(String key, List<String> value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}
