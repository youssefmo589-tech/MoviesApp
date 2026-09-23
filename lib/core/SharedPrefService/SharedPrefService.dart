import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> setPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("Seen", true);
  }

  static Future<bool> getPref() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("Seen") ?? false;
  }
}
