import 'package:flutter/material.dart';

class CustomSnackbars {
  static SnackBar dangerSnackbar(String message) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
  }

  static SnackBar successSnackbar(String message) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    );
  }
}
