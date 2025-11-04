import 'package:flutter/material.dart';

class PixelFrameCard extends StatelessWidget {
  // El contenido interno de la tarjeta (títulos, campos, botones, etc.)
  final Widget child;
  // Opcional: El color de fondo.
  final Color innerBackgroundColor;
  // ELIMINAMOS maxWidth como parámetro ya que el ancho lo da el contenido.

  const PixelFrameCard({
    super.key,
    required this.child,
    this.innerBackgroundColor = const Color(0xFF1A1A2E), // darkBackground
  });

  // Constantes de estilo
  // Color Azul Grisáceo: RGB(55, 108, 133)
  static const Color _frameColor = Color.fromARGB(255, 55, 108, 133); 
  static const double _borderWidth = 4.0;
  static const double _outerRadius = 12.0;
  static const double _innerRadius = 8.0;
  static const double _outerPadding = 4.0;
  static const double _innerPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    // 1. Usamos Center para centrar el marco horizontalmente en la pantalla.
    return Center( 
      // 2. Quitamos ConstrainedBox para permitir que el ancho se defina por el contenido.
      child: Container(
        // 1. Contenedor Exterior (El Borde)
        // El ancho de este Container lo define implícitamente su contenido (child)
        decoration: BoxDecoration(
          border: Border.all(color: _frameColor, width: _borderWidth),
          borderRadius: BorderRadius.circular(_outerRadius),
        ),
        padding: const EdgeInsets.all(_outerPadding),
        
        child: Container(
          // 2. Contenedor Interior (Fondo Oscuro y Padding de Contenido)
          decoration: BoxDecoration(
            color: innerBackgroundColor.withOpacity(0.85), 
            borderRadius: BorderRadius.circular(_innerRadius),
          ),
          padding: const EdgeInsets.all(_innerPadding),
          
          child: child, // El 'child' (Column con COLDWAR) define el ancho.
        ),
      ),
    );
  }
}