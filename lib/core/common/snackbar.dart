import 'package:flutter/material.dart';

showMySnackbar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
      backgroundColor: color ?? Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
