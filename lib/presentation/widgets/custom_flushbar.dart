import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushBar({required BuildContext context, required String message, IconData? icon, Duration duration = const Duration(seconds: 3)}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  Flushbar(
    message: message,
    backgroundColor: isDark ? Colors.grey[800]! : Colors.grey[200]!,
    messageColor: isDark ? Colors.white : Colors.black87,
    icon: icon != null ? Icon(icon, color: isDark ? Colors.white : Colors.black54) : null,
    duration: duration,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
