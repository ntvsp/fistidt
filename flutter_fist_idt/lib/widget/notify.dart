import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageType {
  error,
  warning,
  success,
  normal,
}

class Notify {
  static success(String message) {
    show(message, type: MessageType.success);
  }

  static warning(String message) {
    show(message, type: MessageType.warning);
  }

  static error(String message) {
    show(message, type: MessageType.error);
  }

  static show(String message,
      {MessageType type = MessageType.error, position = SnackPosition.BOTTOM}) {
    Color bgColor = Colors.grey;
    Icon icon = const Icon(Icons.info, color: Colors.white);
    switch (type) {
      case MessageType.error:
        bgColor = const Color(0xFFEA5B5B);
        icon = const Icon(Icons.error, color: Colors.white);
        break;
      case MessageType.warning:
        bgColor = const Color(0xFFFFD166);
        icon = const Icon(Icons.warning, color: Colors.white);
        break;
      case MessageType.success:
        bgColor = const Color(0xFF58C27D);
        icon = const Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      default:
        break;
    }

    Get.rawSnackbar(
        message: message,
        backgroundColor: bgColor,
        icon: icon,
        animationDuration: const Duration(milliseconds: 200),
        snackPosition: position);
  }

  static SnackBar getSnackBar(String message, MessageType type) {
    Color bgColor = Colors.grey;
    switch (type) {
      case MessageType.error:
        bgColor = const Color(0xFFEA5B5B);
        break;
      case MessageType.warning:
        bgColor = const Color(0xFFFFD166);
        break;
      case MessageType.success:
        bgColor = const Color(0xFF58C27D);
        break;
      default:
        break;
    }

    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: bgColor,
    );
  }
}
