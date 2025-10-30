import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;

  const PixelTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Simula el borde "pixelado" con un simple Container
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0, // Simula el grosor del borde
        ),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'PixelFont', // Usar una fuente personalizada si la tienes
        ),
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14.0,
          ),
          contentPadding: EdgeInsets.zero,
          isDense: true,
          border: InputBorder.none, // Quitamos el borde por defecto del TextField
        ),
      ),
    );
  }
}