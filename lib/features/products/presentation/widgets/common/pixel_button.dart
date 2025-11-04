import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const PixelButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = const Color(0xFF00C7B1), // Color turquesa
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          // AÑADIR ESQUINAS REDONDEADAS
          borderRadius: BorderRadius.circular(8.0), 
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'PressStart2P', // La fuente que configuramos
          ),
        ),
      ),
    );
  }
}
