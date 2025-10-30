import 'package:flutter/material.dart';

class PixelBottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PixelBottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4);
    
    // El color cambia si está seleccionado
    final Color itemColor = isSelected ? coldWarBlue : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: itemColor,
            size: 24.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: itemColor,
              fontSize: 10.0,
              fontFamily: 'PixelFont',
            ),
          ),
        ],
      ),
    );
  }
}