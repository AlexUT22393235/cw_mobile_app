import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const PixelTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
      ),
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
    );
  }
}
