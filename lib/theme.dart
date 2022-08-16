import 'package:flutter/material.dart';
import 'package:flutter_flask/constants.dart';

class AppTheme {
  static get lightTheme => ThemeData.light().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline4: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
          subtitle2: TextStyle(
            color: linkTextColor,
            fontWeight: FontWeight.w500,
            decorationColor: linkTextColor,
          ),
          bodyText2: TextStyle(
            color: deepColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryAccentColor,
          selectionHandleColor: primaryAccentColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: primaryColor,
          suffixIconColor: primaryColor,
          filled: true,
          fillColor: fillColor,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ),
      );
}
