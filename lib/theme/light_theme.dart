import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: Color(0xFFDB7124),
  brightness: Brightness.light,
  accentColor: Colors.white,
  hintColor: Color(0xFF9E9E9E),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
