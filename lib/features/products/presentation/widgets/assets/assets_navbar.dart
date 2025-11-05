import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart'; // Asegúrate de importar pixelarticons

class AssetsNavbar extends StatefulWidget {
  const AssetsNavbar({super.key});

  @override
  State<AssetsNavbar> createState() => _AssetsNavbarState();
}

class _AssetsNavbarState extends State<AssetsNavbar> {
  int _selectedIndex = 0; // 0: Escenarios, 1: Personajes, 2: Música
  
  // Constantes de estilo
  static const Color coldWarBlue = Color(0xFF33FFC4);
  static const Color darkBackground = Color(0xFF1A1A2E);

  // Lista de ÍCONOS para las categorías
  // He elegido algunos íconos de pixelarticons que podrían representar cada sección.
  // Puedes ajustarlos según lo que tengas disponible o lo que prefieras.
  final List<IconData> _categoryIcons = const [
    Pixel.camera, // Para Escenarios (paisaje, mapa, etc.)
    Pixel.users,    // Para Personajes
    Pixel.music,     // Para Música
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_categoryIcons.length, (index) {
        final bool isSelected = index == _selectedIndex;
        
        return Expanded( 
          child: Padding(
            padding: EdgeInsets.only(right: index < _categoryIcons.length - 1 ? 8.0 : 0.0),
            
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                // Lógica futura para cambiar el contenido de AssetsContent
              },
              child: Container(
                alignment: Alignment.center,
                // El padding puede ser un poco más generoso ahora con íconos
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0), 
                
                decoration: BoxDecoration(
                  color: isSelected ? coldWarBlue : darkBackground, 
                  border: Border.all(
                    color: coldWarBlue,
                    width: 2.0,
                  ),
                ),
                child: Icon( // <--- ¡AQUÍ ESTÁ EL CAMBIO PRINCIPAL!
                  _categoryIcons[index],
                  size: 20.0, // Ajusta el tamaño del ícono según sea necesario
                  color: isSelected ? darkBackground : coldWarBlue, // Inversión de color
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}