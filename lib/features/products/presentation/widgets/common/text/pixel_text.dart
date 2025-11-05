// widgets/common/pixel_text.dart - Versión con factory constructors
import 'package:flutter/material.dart';
import './styles/text_styles.dart';

class PixelText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height; // <--- 1. PROPIEDAD HEIGHT AÑADIDA AL WIDGET

  // Constructor base
  const PixelText(
    this.text, {
    Key? key,
    this.fontSize,
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow,
    this.height, // <--- 2. AÑADIDO AL CONSTRUCTOR BASE
  }) : super(key: key);

  // Factory constructors como alternativa
  
  // ===================================
  // NUEVO/RENOMBRADO: PixelText.headline
  // ===================================
  factory PixelText.headline(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height, // <--- ACEPTA HEIGHT
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.headline,
      color: color,
      fontWeight: FontWeight.bold,
      textAlign: textAlign,
      height: height, // <--- PASA HEIGHT
    );
  }

  factory PixelText.displayLarge(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height,
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.display,
      color: color,
      fontWeight: FontWeight.bold,
      textAlign: textAlign,
      height: height,
    );
  }
  
  // (Omitimos headlineMedium si headline es el nuevo nombre)

  factory PixelText.titleLarge(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height,
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.title,
      color: color,
      fontWeight: FontWeight.bold,
      textAlign: textAlign,
      height: height,
    );
  }

  // ===================================
  // MODIFICADO: PixelText.bodyLarge
  // ===================================
  factory PixelText.bodyLarge(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height, // <--- ACEPTA HEIGHT
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.large,
      color: color,
      textAlign: textAlign,
      height: height, // <--- PASA HEIGHT
    );
  }

  factory PixelText.bodyMedium(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height,
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.medium,
      color: color,
      textAlign: textAlign,
      height: height,
    );
  }

  factory PixelText.bodySmall(
    String text, {
    Key? key,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.center,
    double? height,
  }) {
    return PixelText(
      text,
      key: key,
      fontSize: PixelTextStyles.small,
      color: color,
      textAlign: textAlign,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? PixelTextStyles.medium,
        fontWeight: fontWeight,
        fontFamily: 'PressStart2P',
        height: height, // <--- 3. HEIGHT AÑADIDO AL ESTILO
      ),
    );
  }
}