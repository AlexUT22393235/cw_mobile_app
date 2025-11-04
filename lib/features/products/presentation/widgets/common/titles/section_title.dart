import 'package:flutter/material.dart';
// Importación de tu widget de texto reutilizable
import '../text/pixel_text.dart'; 

class SectionTitle extends StatelessWidget {
  // Parámetro requerido: el texto de la sección (ej. 'INICIA SESIÓN')
  final String titleText; 

  const SectionTitle({
    super.key,
    required this.titleText,
  });

  // Estilos fijos para la consistencia visual
  static const Color _titleColor = Colors.white;
  static const double _gapBelowTitle = 20.0; 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
      children: [
        // 1. Título de la Sección: Uso de tu factory constructor titleLarge
        PixelText.titleLarge(
          titleText, 
          color: _titleColor,
          // Por defecto, PixelText.titleLarge ya usa FontWeight.bold y TextAlign.center
        ),
        
        // 2. Espacio de separación consistente
        const SizedBox(height: _gapBelowTitle),
      ],
    );
  }
}