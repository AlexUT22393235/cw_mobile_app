import 'package:flutter/material.dart';

// Importaciones necesarias
import '../../screens/login_page.dart';
import '../../screens/register_page.dart'; // Si aún se usa
import '../../screens/navigation_gateway.dart'; // El nuevo contenedor principal
import 'pixel_animated_background.dart'; 

// === Enum para manejar los estados de la aplicación ===
enum AppScreen { 
  auth, // Estado de autenticación (Login/Register)
  main, // Estado de la aplicación principal (NavigationGateway)
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // Estado inicial: Muestra Autenticación (Login)
  AppScreen _currentScreen = AppScreen.auth; 
  // Sub-estado de autenticación (Login o Register)
  bool _isLogin = true; 

  // Función para completar la autenticación (pasa de Auth a Main/Navigation)
  void _goToMain() {
    setState(() {
      _currentScreen = AppScreen.main;
    });
  }
  
  // Función para cambiar la vista de Auth a Register
  void _goToRegister() {
    setState(() {
      _isLogin = false;
    });
  }

  // Función para cambiar la vista de Register/Main a Login
  void _goToLogin() {
    setState(() {
      _currentScreen = AppScreen.auth; // ⚠️ Importante: Vuelve al estado de Auth
      _isLogin = true;
    });
  }


  // Widget que se renderiza según el estado principal
  Widget _getCurrentPage() {
    if (_currentScreen == AppScreen.main) {
      // Si el usuario está autenticado, muestra el Navigation Gateway
      // ⚠️ IMPLEMENTACIÓN DEL LOGOUT: Pasamos _goToLogin como callback onLogout
      return NavigationGateway(
        onLogout: _goToLogin, // <--- FUNCIÓN QUE CIERRA LA SESIÓN Y REDIRIGE
      );
    }
    
    // Si no está autenticado, muestra Login o Register
    if (_isLogin) {
      return LoginPage(
        // Al hacer login exitoso, vamos a Main/Navigation
        onLoginRequested: _goToMain, 
        // Al pedir registro, vamos a Register
        onRegisterRequested: _goToRegister,
        key: const ValueKey('login'), 
      );
    } else {
      return RegisterPage(
        // Al completar registro o cancelar, volvemos a Login
        onLoginRequested: _goToLogin, 
        // Asumo que el registro también necesita un callback (ej: para ir a Main o Login)
        onRegisterRequested: _goToLogin, 
        key: const ValueKey('register'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          // CAPA 1: FONDO ANIMADO PERSISTENTE
          const PixelAnimatedBackground(),

          // CAPA 2: CONTENIDO DINÁMICO (Login/Register o NavigationGateway)
          // Usamos AnimatedSwitcher para una transición suave entre Login/Navigation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _getCurrentPage(),
          ),
        ],
      ),
    );
  }
}