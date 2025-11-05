import 'package:flutter/material.dart';

// Importación de la barra de navegación y las páginas
import '../widgets/common/pixel_bottom_nav_item.dart'; 
import 'home_page.dart';     
import 'chatbot_page.dart';  

class NavigationGateway extends StatefulWidget {
  const NavigationGateway({super.key});

  @override
  State<NavigationGateway> createState() => _NavigationGatewayState();
}

class _NavigationGatewayState extends State<NavigationGateway> {
  // 1. Estado que rastrea la página seleccionada
  int _selectedIndex = 0; 

  // 2. Lista de Widgets de las páginas de navegación (el orden debe coincidir con el NavBar)
  final List<Widget> _pageWidgets = const <Widget>[
    // Index 0: HOME 
    HomePage(), 
    // Index 1: LORE (Placeholder)
    Center(child: Text("Lore Page Placeholder", style: TextStyle(color: Colors.white))), 
    // Index 2: ASSETS (Placeholder)
    Center(child: Text("Assets Page Placeholder", style: TextStyle(color: Colors.white))), 
    // Index 3: CHATBOT 
    ChatbotPage(), 
    // Index 4: PERFIL (Placeholder)
    Center(child: Text("Profile Page Placeholder", style: TextStyle(color: Colors.white))), 
  ];


  // 3. Función que actualiza el estado (El disparador)
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index; 
      });
      // La clave es que este setState redibuja el IndexedStack con el nuevo índice.
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent, 
      
      bottomNavigationBar: PixelBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // CONEXIÓN CORRECTA
      ), 
      
      // 4. IndexedStack: Cambia la vista.
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageWidgets,
      ),
    );
  }
}