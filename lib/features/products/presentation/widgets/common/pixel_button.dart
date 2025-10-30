import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const PixelButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = const Color(0xFF33FFC4), // Color turquesa de la imagen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Dejamos el callback, aunque ahora será null
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: 2.0,
          ),
          // No hay necesidad de BorderRadius aquí para mantener el aspecto cuadrado/pixelado
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.black, // Texto oscuro sobre el color claro
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'PixelFont',
          ),
        ),
      ),
    );
  }
}