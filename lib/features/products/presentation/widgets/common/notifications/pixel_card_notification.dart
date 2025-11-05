import 'package:flutter/material.dart';

class PixelCardListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color borderColor;

  const PixelCardListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
  // Estilizado: borde pixelado utilizando BoxDecoration
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Texto: título en mayúsculas (estilo de énfasis)
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF33FFC4), // Color turquesa de énfasis
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PressStart2P',
            ),
          ),
          const SizedBox(height: 5.0),
          // Texto: subtítulo con opacidad para menor énfasis
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.0,
              fontFamily: 'PressStart2P',
            ),
          ),
        ],
      ),
    );
  }
}