import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  static Future<bool> sendNotification({
    required String title,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://alfostat-notification.youssefmo589.workers.dev/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'message': message}),
      );
      print("FCM Status Code: ${response.statusCode}");
      print("FCM Response: ${response.body}");

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print("Notification Error: $e");
      return false;
    }
  }
}
