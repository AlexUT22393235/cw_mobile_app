import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';

class AssetsContent extends StatelessWidget {
  const AssetsContent({super.key});
  
  static const Color coldWarBlue = Color(0xFF33FFC4);
  static const Color darkBackground = Color(0xFF1A1A2E);

  // Datos simulados de los assets
  final List<String> _assetImages = const [
    'assets/images/map_asset_1.png', 
    'assets/images/map_asset_2.png',
    // Relleno para la cuadrícula
    'a','b','c','d','e','f','g','h','i','j', 
  ];

  @override
  Widget build(BuildContext context) { // <--- ¡CORRECCIÓN APLICADA AQUÍ!
    // Usamos GridView para el diseño de cuadrícula.
    return GridView.builder(
      // CRUCIAL: Usamos shrinkWrap para que GridView no intente tomar altura infinita
      shrinkWrap: true, 
      // CRUCIAL: physics: NeverScrollableScrollPhysics para evitar scroll anidado.
      physics: const NeverScrollableScrollPhysics(), 
      
      itemCount: 12, // Basado en la maqueta (3 filas de 4)
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 columnas
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.8, // Ajuste para que la imagen y el botón quepan
      ),
      itemBuilder: (context, index) {
        return AssetGridItem( // Usamos el widget corregido
          // Simulamos el path de la imagen
          imagePath: _assetImages.length > index ? _assetImages[index] : 'assets/images/placeholder.png', 
        );
      },
    );
  }
}

// === WIDGET MODULAR PARA CADA CELDA DE LA CUADRÍCULA ===

class AssetGridItem extends StatelessWidget {
  final String imagePath;
  
  const AssetGridItem({super.key, required this.imagePath});

  static const Color coldWarBlue = Color(0xFF33FFC4);
  static const Color darkBackground = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: coldWarBlue, width: 1.0),
        color: darkBackground.withOpacity(0.9),
      ),
      child: Column(
        children: <Widget>[
          // 1. Área de Imagen (Placeholder)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                'https://via.placeholder.com/150/0000FF/808080?text=ASSET', // Placeholder de imagen
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.white70, size: 24),
                ),
              ),
            ),
          ),
          
          // 2. Botón de Descarga
          Container(
            padding: const EdgeInsets.all(4.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: coldWarBlue, width: 1.0)),
            ),
            child: GestureDetector(
              onTap: () {
                // Lógica de descarga
              },
              child: const Icon(
                Pixel.download, // Icono de descarga pixelado
                color: coldWarBlue,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}