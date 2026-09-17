import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void success(String message) {
    _show(message: message, color: Colors.green, icon: Icons.check_circle);
  }

  static void warning(String message) {
    _show(
      message: message,
      color: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void error(String message) {
    _show(message: message, color: Colors.red, icon: Icons.error);
  }

  static void _show({
    required String message,
    required Color color,
    required IconData icon,
  }) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      enableSlideOff: true,

      onlyOne: true,
      crossPage: true,
      align: const Alignment(0, -0.92),

      toastBuilder: (_) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },

      animationDuration: const Duration(milliseconds: 350),
      animationReverseDuration: const Duration(milliseconds: 250),
    );
  }
}
