// styles/text_styles.dart
import 'package:flutter/material.dart';

class PixelTextStyles {
  // Tamaños proporcionales para PressStart2P
  static const double extraSmall = 10.0;
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double extraLarge = 18.0;
  static const double title = 20.0;
  static const double headline = 32.0;
  static const double display = 38.0;

  // Estilos predefinidos
  static TextStyle displayLarge({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: display,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headlineMedium({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: headline,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle titleLarge({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: title,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyLarge({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: large,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: medium,
      color: color,
    );
  }

  static TextStyle bodySmall({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: small,
      color: color,
    );
  }

  static TextStyle labelLarge({Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: extraLarge,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle labelMedium({Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: large,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle labelSmall({Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: medium,
      color: color,
      fontWeight: fontWeight,
    );
  }
}