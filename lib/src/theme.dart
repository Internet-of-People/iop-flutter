import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.teal,
  primarySwatch: MaterialColor(0xff009688, const {
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
  headline1: TextStyle(color: Colors.teal[800], fontSize: 24, wordSpacing: -1),
  headline2: TextStyle(
      color: Colors.teal[900], fontSize: 20, fontWeight: FontWeight.bold),
  bodyText1: TextStyle(fontSize: 16),
  bodyText2: TextStyle(fontSize: 12),
);
