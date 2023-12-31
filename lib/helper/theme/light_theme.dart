import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'NewFonts',
  primaryColor: const Color(0xFFBFE3FF),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  accentColor: Color(0xFF2E76B2),
  hintColor: const Color(0xFF9E9E9E),
  colorScheme: const ColorScheme.light(primary: Color(0xFF0079E3), secondary: Color(0xFF004C8E),
    tertiary: Color(0xFFF9D4A8),tertiaryContainer: Color(0xFFADC9F3),
    onTertiaryContainer: Color(0xFF33AF74),
    primaryContainer: Color(0xFF9AECC6),secondaryContainer: Color(0xFFF2F2F2),),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);