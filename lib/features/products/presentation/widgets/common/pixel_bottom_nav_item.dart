import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart'; // Importación: paquete de iconos pixelados

// NavItemConfig: configuración del elemento de la barra de navegación
// Usa IconData proporcionado por el paquete pixelarticons

class NavItemConfig {
  // Comentario: IconData empleado para los iconos de navegación
  final IconData icon;
  final String label;
  final int index;

  const NavItemConfig({
    required this.icon,
    required this.label,
    required this.index,
  });
}

// PixelBottomNavItem: widget individual de la barra inferior

class PixelBottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PixelBottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  // Constante de color: color por defecto del ítem
  static const Color _coldWarBlue = Color(0xFF33FFC4);

  @override
  Widget build(BuildContext context) {
    // Estilo: color cambia cuando el ítem está seleccionado
    final Color itemColor = isSelected ? _coldWarBlue : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: itemColor, size: 24.0),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: itemColor,
              fontSize: 10.0,
              // Tip: usar la fuente personalizada PixelFont para texto pequeño
              fontFamily: 'PixelFont',
            ),
          ),
        ],
      ),
    );
  }
}

// PixelBottomNavBar: widget compuesto que agrupa varios elementos de navegación

class PixelBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  // Configuración: lista de NavItemConfig que define íconos y etiquetas
  // Notas: se han usado iconos equivalentes del paquete Pixel
  static const List<NavItemConfig> items = [
    NavItemConfig(icon: Pixel.home, label: 'Home', index: 0),
    NavItemConfig(icon: Pixel.book, label: 'Lore', index: 1),
    NavItemConfig(icon: Pixel.file, label: 'Assets', index: 2),
    NavItemConfig(icon: Pixel.chat, label: 'Chatbot', index: 3),
    NavItemConfig(icon: Pixel.close, label: 'Salir', index: 4),
  ];

  const PixelBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  // Constantes de estilo para la barra inferior
  static const Color _coldWarBlue = Color(0xFF33FFC4);
  static const Color _darkBackground = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _coldWarBlue, width: 2.0)),
        color: _darkBackground,
      ),
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0 + bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return PixelBottomNavItem(
            icon: item.icon,
            label: item.label,
            isSelected: selectedIndex == item.index,
            onTap: () => onItemTapped(item.index),
          );
        }).toList(),
      ),
    );
  }
}
