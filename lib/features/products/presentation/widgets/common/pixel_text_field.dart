import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const PixelTextField({
    super.key, // Usamos super.key por convención
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
      ),
      // === CORRECCIÓN CLAVE: Envolvemos el TextField en Material ===
      child: Material( 
        type: MaterialType.transparency, // Asegura que no añade un fondo extra
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black, // Texto negro
            fontSize: 16.0,
            fontFamily: 'PressStart2P', // ¡Tu fuente pixelada!
          ),
          decoration: InputDecoration(
            hintText: labelText.toUpperCase(), // El labelText es el hint
            hintStyle: TextStyle(
              color: Colors.grey[600], // Placeholder gris
              fontSize: 14.0,
              fontFamily: 'PressStart2P',
            ),
            border: InputBorder.none, // Eliminar borde nativo
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          ),
        ),
      ),
    );
  }
}
