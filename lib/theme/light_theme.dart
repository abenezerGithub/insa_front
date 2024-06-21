import 'package:flutter/material.dart';
import 'package:insa_report/constants/colors.dart';

final lightThemeData = ThemeData.light(useMaterial3: true).copyWith(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
  scaffoldBackgroundColor: Colors.white
  // textTheme: const TextTheme(
  //   displaySmall:
  //       TextStyle(fontFamily: "Poppins", fontSize: 12, color: Colors.black),
  //   displayMedium:
  //       TextStyle(fontFamily: "Poppins", fontSize: 13, color: Colors.black),
  // ),
);
