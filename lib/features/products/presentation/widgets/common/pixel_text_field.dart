import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon; // [técnico] Nueva propiedad opcional para el ícono al final

  const PixelTextField({
    super.key, // Se pasa la clave al constructor padre (convención Flutter)
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon, // [técnico] Se acepta la nueva propiedad en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Fondo: color blanco para el campo
        borderRadius: BorderRadius.circular(8.0), // Bordes: radio de 8px
      ),
      // Wrapping: TextField envuelto en Material para controlar su renderizado
      child: Material( 
        type: MaterialType.transparency, // Evita que Material añada un fondo adicional
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black, // Estilo: color de texto principal
            fontSize: 16.0,
            fontFamily: 'PressStart2P', // Fuente: PressStart2P (pixelada)
          ),
          decoration: InputDecoration(
            hintText: labelText.toUpperCase(), // Hint: usar label en mayúsculas como placeholder
            hintStyle: TextStyle(
              color: Colors.grey[600], // Color del placeholder
              fontSize: 14.0,
              fontFamily: 'PressStart2P',
            ),
            border: InputBorder.none, // Input: eliminar borde nativo para estilo personalizado
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            
            // ⚠️ IMPLEMENTACIÓN CLAVE: Se añade el ícono de sufijo de forma opcional
            suffixIcon: suffixIcon,
            // [técnico] Ajustar el padding del ícono si es necesario para el estilo pixelado
            suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40), 
          ),
        ),
      ),
    );
  }
}