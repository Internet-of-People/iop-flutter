import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.teal,
  primaryColorLight: Colors.teal[400],
  primaryColorDark: Colors.teal[800],
  primarySwatch: const MaterialColor(0xff009688, {
    50: Color(0xffa0f8f2),
    100: Color(0xff88f7ef),
    200: Color(0xff58f3e9),
    300: Color(0xff28f0e3),
    400: Color(0xff0fd7c9),
    500: Color(0xff009688),
    600: Color(0xff0a8f86),
    700: Color(0xff087770),
    800: Color(0xff075f59),
    900: Color(0xff054843)
  }),
  backgroundColor: Colors.white,
  textTheme: textTheme,
);

final TextTheme textTheme = TextTheme(
  // Text for onboarding titles
  headline1: TextStyle(
      color: Colors.teal[800],
      fontSize: 28,
      fontWeight: FontWeight.bold,
      wordSpacing: -1),
  // Text for in-app titles
  headline2: TextStyle(
      color: Colors.teal[900], fontSize: 20, fontWeight: FontWeight.bold),
  // Text inside mnemonicTable
  headline3: const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
  // Text for onboarding description
  bodyText1: TextStyle(color: Colors.teal[800], fontSize: 18),
  // Text for Form Fields
  bodyText2: TextStyle(color: Colors.teal[400], fontSize: 14),
  button: const TextStyle(color: Colors.white, fontSize: 14),
);
