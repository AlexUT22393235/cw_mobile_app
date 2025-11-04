import 'package:flutter/material.dart';
// Importación de tu widget de texto reutilizable
import '../text/pixel_text.dart'; 

class ApplicationTitle extends StatelessWidget {
  // Único parámetro requerido: el texto del título (ej. 'COLDWAR')
  final String titleText; 

  const ApplicationTitle({
    super.key,
    required this.titleText,
  });

  // --- Estilos fijos y Constantes de Color ---
  // Definimos la constante de color que antes era local en login_page.dart
  static const Color _coldWarBlue = Color(0xFF33FFC4);
  
  static const double _lineWidth = 180.0;
  static const double _gapBelowLine = 30.0; 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
      children: [
        // 1. Título principal: Uso de tu factory constructor
        PixelText.displayLarge(
          titleText, 
          color: _coldWarBlue, // Usa la constante definida aquí
        ),
        
        // 2. Línea divisoria (Separador)
        Container(
          height: 2.0,
          color: _coldWarBlue, // Usa el mismo color
          width: _lineWidth, 
        ),
        
        // 3. Espacio de separación consistente
        const SizedBox(height: _gapBelowLine),
      ],
    );
  }
}