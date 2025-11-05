import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final IconData? icon;
  // Usamos 'color' para ser consistente con la definición original del widget
  final Color color; 

  // Constantes de color para el contraste invertido (estilo pixel)
  static const Color _darkContrast = Color(0xFF1A1A2E); // Color muy oscuro
  static const Color _lightContrast = Colors.white; 

  const PixelButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = const Color(0xFF33FFC4), // Color por defecto
    this.icon,
  }) : super(key: key);
  
  // Determina el color del texto/ícono basado en el color de fondo para asegurar contraste.
  Color _getForegroundColor() {
    // Si el color de fondo es brillante (verde, rojo, o turquesa por defecto), usamos texto oscuro.
    // Esto asegura el efecto de contraste "pixelado".
    if (color == const Color(0xFF5FFB17) || 
        color == const Color(0xFFF91818) ||
        color == const Color(0xFF33FFC4)) {
        return _darkContrast; 
    }
    return _lightContrast; 
  }


  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    final Color effectiveColor = isDisabled ? color.withOpacity(0.5) : color;
    final Color foregroundColor = _getForegroundColor();
    
    // Si el texto está vacío y hay un ícono, lo consideramos un botón de solo ícono.
    final bool isIconButton = text.isEmpty && icon != null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: effectiveColor,
          // Borde más marcado
          border: Border.all(color: foregroundColor, width: 2.0),
          borderRadius: BorderRadius.circular(2.0),
        ),
        // Ajuste de padding según sea ícono o texto
        padding: isIconButton 
            ? const EdgeInsets.all(12.0) 
            : const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
        
        alignment: Alignment.center,
        
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Mostrar Ícono (si existe)
            if (icon != null)
              Icon(
                icon,
                color: foregroundColor,
                size: isIconButton ? 24.0 : 18.0, 
              ),

            // 2. Separador (si hay Ícono Y Texto)
            if (icon != null && text.isNotEmpty)
              const SizedBox(width: 8.0),

            // 3. Mostrar Texto (si existe)
            if (text.isNotEmpty)
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PressStart2P',
                ),
              ),
          ],
        ),
      ),
    );
  }
}