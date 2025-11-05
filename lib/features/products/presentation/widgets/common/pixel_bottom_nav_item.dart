import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart'; // 1. IMPORTAR EL PAQUETE

// ===================================================================
// 1. CLASE DE CONFIGURACIÓN DE ÍTEM (NavItemConfig)
//    Ahora usa IconData de pixelarticons.
// ===================================================================

class NavItemConfig {
  // Mantenemos IconData porque Pixel.home es de tipo IconData
  final IconData icon; 
  final String label;
  final int index;

  const NavItemConfig({
    required this.icon, 
    required this.label, 
    required this.index,
  });
}

// ===================================================================
// 2. WIDGET DE ÍTEM INDIVIDUAL (PixelBottomNavItem) - Actualizado
// ===================================================================

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
  
  // Constante de color compartida
  static const Color _coldWarBlue = Color(0xFF33FFC4);

  @override
  Widget build(BuildContext context) {
    // El color cambia si está seleccionado
    final Color itemColor = isSelected ? _coldWarBlue : Colors.white;

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
              // Asumo que 'PixelFont' es tu fuente pixelada
              fontFamily: 'PixelFont', 
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// 3. WIDGET DE BARRA COMPUESTA (PixelBottomNavBar) - Actualizado
// ===================================================================

class PixelBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  // Definición de todos los elementos de la barra
  // 2. REEMPLAZO DE ICONS.xxx POR PIXEL.xxx (usando íconos equivalentes)
  static const List<NavItemConfig> items = [
    NavItemConfig(icon: Pixel.home, label: 'Home', index: 0),       // Icons.home -> Pixel.home
    NavItemConfig(icon: Pixel.book, label: 'Lore', index: 1),       // Icons.menu_book -> Pixel.book o Pixel.archive
    NavItemConfig(icon: Pixel.file, label: 'Assets', index: 2),      // Icons.inventory -> Pixel.box o Pixel.archive
    NavItemConfig(icon: Pixel.chat, label: 'Chatbot', index: 3),    // Icons.chat_bubble -> Pixel.chat
    NavItemConfig(icon: Pixel.user, label: 'Perfil', index: 4),     // Icons.person -> Pixel.user
  ];

  const PixelBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  // Constantes de estilo
  static const Color _coldWarBlue = Color(0xFF33FFC4);
  static const Color _darkBackground = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: _coldWarBlue, width: 2.0),
        ),
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