import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class SnackBarHelper {
  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppColors.primary;
        textColor = AppColors.primaryForeground;
        break;
      case SnackBarType.error:
        backgroundColor = AppColors.destructive;
        textColor = AppColors.destructiveForeground;
        break;
      case SnackBarType.warning:
        backgroundColor = AppColors.accent;
        textColor = AppColors.accentForeground;
        break;
      case SnackBarType.info:
        backgroundColor = AppColors.secondary;
        textColor = AppColors.secondaryForeground;
        break;
    }

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: backgroundColor,

      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
