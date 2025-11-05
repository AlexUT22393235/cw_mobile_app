import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Necesario para eliminar el access_token

// Importación de la barra de navegación y las páginas
import '../widgets/common/pixel_bottom_nav_item.dart'; // Corregido: asumimos el nombre correcto
import '../widgets/common/pixel_button.dart'; // Necesario para los botones del modal
import '../widgets/common/text/pixel_text.dart'; // Necesario para el texto del modal
import 'home_page.dart';
import 'chatbot_page.dart';
import 'assets_page.dart'; 
import 'lore_page.dart';

// Definición del tipo de función para el callback de logout
typedef VoidCallback = void Function(); 

// 1. NavigationGateway debe aceptar el callback de logout del AppShell
class NavigationGateway extends StatefulWidget {
  final VoidCallback onLogout; // <--- NUEVO: Callback para cerrar sesión
  
  const NavigationGateway({super.key, required this.onLogout});

  @override
  State<NavigationGateway> createState() => _NavigationGatewayState();
}

class _NavigationGatewayState extends State<NavigationGateway> {
  
  int _selectedIndex = 0;

  // 2. Lista de Widgets, incluyendo el placeholder para Perfil/Logout (Index 4)
  final List<Widget> _pageWidgets = const <Widget>[
    // Index 0: HOME
    HomePage(),
    // Index 1: LORE
    LorePage(),
    // Index 2: ASSETS
    AssetsPage(), 
    // Index 3: CHATBOT
    ChatbotPage(),
    // Index 4: PERFIL (Usaremos un placeholder, el tap se maneja en el NavBar)
    ProfileLogoutView(), 
  ];

  // 3. Función que actualiza el estado o inicia el Logout
  void _onItemTapped(int index) {
    // ⚠️ REGLA CLAVE: Si el índice es 4 (Perfil), mostramos el modal de confirmación.
    if (index == 4) {
      _showLogoutConfirmation(context);
    } else if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // === 4. LÓGICA DE LOGOUT ===
  Future<void> _handleLogout() async {
    // 1. ELIMINAR EL TOKEN
    final prefs = await SharedPreferences.getInstance();
    // Elimina la clave del token almacenada localmente
    await prefs.remove('access_token'); 
    
    // 2. Redirigir al Login
    widget.onLogout(); 
  }

  // === 5. FUNCIÓN DEL MODAL DE CONFIRMACIÓN ===
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E).withOpacity(0.95), // Fondo oscuro
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF33FFC4), width: 2), // Borde pixelado
            borderRadius: BorderRadius.zero,
          ),
          contentPadding: const EdgeInsets.all(20),
          
          title: PixelText.titleLarge(
            "CERRAR SESIÓN",
            color: const Color(0xFF33FFC4),
            textAlign: TextAlign.center,
          ),
          content: PixelText.bodyLarge(
            "¿Seguro que quieres cerrar sesión?",
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
          
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            // Botón NO (Cancelar)
            PixelButton(
              text: 'NO', 
              onPressed: () => Navigator.of(context).pop(), // Cierra el modal
            ),
            
            // Botón SÍ (Aceptar y Logout)
            PixelButton(
              text: 'SÍ', 
              // La lógica de logout no es asíncrona aquí, ya que el modal ya se está construyendo
              onPressed: () {
                Navigator.of(context).pop(); // 1. Cerrar modal
                _handleLogout();             // 2. Ejecutar la lógica de logout y redirección
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: PixelBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, 
      ),
      body: IndexedStack(index: _selectedIndex, children: _pageWidgets),
    );
  }
}

// 6. Widget Placeholder para el Index 4
class ProfileLogoutView extends StatelessWidget {
  const ProfileLogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Mensaje de ayuda para la UX
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: PixelText.bodyLarge(
          "Presiona el ícono de Perfil nuevamente para confirmar el cierre de sesión. El token de sesión será eliminado.",
          color: Colors.white70,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}