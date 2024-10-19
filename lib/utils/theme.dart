import 'package:flutter/material.dart';

const String fontFamily = 'Montserrat';
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColorDark: const Color(0xff2E36FF),
  primaryColorLight: const Color(0xffFF9F2E),
  backgroundColor: const Color(0xffF3F3F3),
  hintColor: Colors.blueAccent,
  cardColor: const Color(0xff226060),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: fontFamily),
    bodyMedium: TextStyle(fontFamily: fontFamily),
    displayLarge: TextStyle(fontFamily: fontFamily),
    displayMedium: TextStyle(fontFamily: fontFamily),
    // Add other text styles as needed
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff888888)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal,
  hintColor: Colors.tealAccent,
);
