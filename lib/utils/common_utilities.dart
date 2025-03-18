import 'package:flutter/material.dart';

enum SnackBarType { error, success, warning }

commonSnackBar(
    {required String? message,
    SnackBarType? type,
    required BuildContext context}) {
  Icon icon;
  Color backgroundColor;

  switch (type) {
    case SnackBarType.error:
      backgroundColor = Colors.red;
      icon = const Icon(
        Icons.error,
        color: Colors.white,
      );
      break;
    case SnackBarType.warning:
      backgroundColor = Colors.orangeAccent;
      icon = const Icon(
        Icons.warning,
        color: Colors.white,
      );
      break;
    case SnackBarType.success:
    default:
      backgroundColor = Colors.green;
      icon = const Icon(
        Icons.check_circle,
        color: Colors.white,
      );
      break;
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            message ?? "",
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
