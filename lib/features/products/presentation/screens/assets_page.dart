import 'package:flutter/material.dart';

// Importación del layout general
import '../screens/general/basic_general_screen.dart'; 
// Importación de los widgets de esta vista
import '../widgets/assets/assets_navbar.dart';
import '../widgets/assets/assets_content.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});
  
  // Constante de color (si se necesita aquí, aunque se usa más en los widgets hijos)
  static const Color coldWarBlue = Color(0xFF33FFC4);

  @override
  Widget build(BuildContext context) {
    // Usamos BasicContentLayout como el marco principal
    return BasicContentLayout(
      sectionTitleText: 'ASSETS', // Título de la sección según la maqueta
      
      content: Column(
        mainAxisSize: MainAxisSize.min, // El contenido se ajusta
        crossAxisAlignment: CrossAxisAlignment.stretch, // Estira los elementos horizontalmente
        children: const <Widget>[
          
          // 1. Barra de Navegación Superior (Escenarios, Personajes, Música)
          AssetsNavbar(),
          
          SizedBox(height: 20.0),
          
          // 2. Área de Contenido (Grid de los Assets)
          // Se usa un Expanded dentro del assets_content para manejar el scroll
          AssetsContent(),
        ],
      ),
    );
  }
}