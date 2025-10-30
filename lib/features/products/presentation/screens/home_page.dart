import 'package:flutter/material.dart';
import '../widgets/common/pixel_card_list_item.dart';
import '../widgets/common/pixel_bottom_nav_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Índice para manejar el elemento seleccionado

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Aquí iría la lógica de navegación real (ej. cambiar el body)
  }

  // Widget para el texto de estilo pixelado
  Widget _buildPixelText(String text, {double fontSize = 16.0, Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'PixelFont',
      ),
    );
  }

  // === BARRA DE NAVEGACIÓN INFERIOR ===
  Widget _buildBottomNavBar() {
    const Color coldWarBlue = Color(0xFF33FFC4);
    
    // 1. OBTENER EL ESPACIO INFERIOR DEL SISTEMA (SafeArea padding)
    // Usamos MediaQuery para obtener el padding inferior del sistema (notch, barra de gestos, etc.)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // Contenedor que simula el borde pixelado alrededor de la barra
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: coldWarBlue, width: 2.0),
        ),
        color: const Color(0xFF1A1A2E).withOpacity(0.8), // Fondo oscuro
      ),
      // 2. AÑADIR EL PADDING INFERIOR PARA LEVANTARLA
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0 + bottomPadding), // Agrega el padding del sistema
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // ... (Resto de PixelBottomNavItem) ...
          PixelBottomNavItem(
            icon: Icons.home,
            label: 'Home',
            isSelected: _selectedIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          PixelBottomNavItem(
            icon: Icons.menu_book,
            label: 'Lore',
            isSelected: _selectedIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          PixelBottomNavItem(
            icon: Icons.inventory,
            label: 'Assets',
            isSelected: _selectedIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          PixelBottomNavItem(
            icon: Icons.chat_bubble,
            label: 'Chatbot',
            isSelected: _selectedIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
          PixelBottomNavItem(
            icon: Icons.person,
            label: 'Perfil',
            isSelected: _selectedIndex == 4,
            onTap: () => _onItemTapped(4),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF1A1A2E); 
    const Color coldWarBlue = Color(0xFF33FFC4);

    return Scaffold(
      backgroundColor: darkBackground,
      // La barra de navegación es un widget personalizado
      bottomNavigationBar: _buildBottomNavBar(), 
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            // El "marco" principal
            decoration: BoxDecoration(
              border: Border.all(color: coldWarBlue, width: 4.0),
              color: darkBackground.withOpacity(0.8),
            ),
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 400),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Título principal: COLDWAR
                _buildPixelText(
                  'COLDWAR',
                  fontSize: 48.0,
                  color: coldWarBlue,
                  fontWeight: FontWeight.bold,
                ),
                Container(height: 2.0, color: coldWarBlue, width: 150.0), // Subrayado
                const SizedBox(height: 20.0),

                // Título: INICIO
                _buildPixelText(
                  'INICIO',
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 25.0),
                
                // === LISTA DE ELEMENTOS ===
                PixelCardListItem(
                  title: 'NOVEDADES',
                  subtitle: 'Últimas apcticidades del juego',
                  borderColor: coldWarBlue, // Borde turquesa para destacar
                ),
                PixelCardListItem(
                  title: 'MISIÓN DIARIA',
                  subtitle: 'Derota 5 Pingüinos Árticos',
                  borderColor: Colors.white,
                ),
                PixelCardListItem(
                  title: 'EVENTO SEMANAL',
                  subtitle: '0:2:442', // Asumiendo que es un contador
                  borderColor: Colors.white,
                ),
                // Aquí irían más elementos si los hubiera
              ],
            ),
          ),
        ),
      ),
    );
  }
}