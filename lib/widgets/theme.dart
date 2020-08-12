import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ColorTheme {

  const ColorTheme();

  static const Color loginGradientStart = const Color(0xFF42A5F5);
  static const Color loginGradientEnd = const Color(0xFF1E88E5);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}