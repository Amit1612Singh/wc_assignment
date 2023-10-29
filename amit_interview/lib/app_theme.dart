import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData appTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200], // Light grey background
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.blue,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      maximumSize: MaterialStatePropertyAll(Size.infinite),
      backgroundColor: MaterialStatePropertyAll(AppColors.blue),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
    ),
  ),
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
  useMaterial3: true,
);
