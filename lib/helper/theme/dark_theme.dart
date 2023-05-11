import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'NewFonts',
  primaryColor: const Color(0xFF2A160C),
  brightness: Brightness.dark,
  highlightColor: const Color(0xFF252525),
  accentColor: const Color(0xFF99592A),
  hintColor: const Color(0xFFc7c7c7),
  colorScheme : const ColorScheme.dark(primary: Color(0xFF64BDF9),
    secondary: Color(0xFF78BDFC),
    tertiary: Color(0xFF865C0A),
    tertiaryContainer: Color(0xFF6C7A8E),
    onTertiaryContainer: Color(0xFF0F5835),
    primaryContainer: Color(0xFF208458),
    secondaryContainer: Color(0xFFF2F2F2),),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
