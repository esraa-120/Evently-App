import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SnackBarServer {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            margin: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE6FFF4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    msg,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showWarningMessage(String msg, {bool isLoadingWarning = false}) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            margin: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.yellow),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(msg, style: const TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            margin: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(msg, style: const TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
}
