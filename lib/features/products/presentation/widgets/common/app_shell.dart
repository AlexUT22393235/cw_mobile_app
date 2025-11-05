// Archivo: lib/presentation/screens/app_shell.dart (Hipótesis)

import 'package:flutter/material.dart';
// IMPORTACIONES CLAVE
import '../../screens/navigation_gateway.dart';
// import 'otro_archivo_fondo.dart'; // Tu fondo animado, si aplica

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ NOTA: Asumo que tienes una lógica de autenticación simple.
    const bool isAuthenticated = true; // Simulación de usuario logueado

    return Scaffold(
      // Configuración de tu fondo principal (ej. fondo oscuro, animaciones)
      backgroundColor: const Color(0xFF1A1A2E), 
      body: Stack(
        children: [
          // 1. Capa de Fondo (Si tienes un fondo animado o un gradiente estático)
          // const PixelAnimatedBackground(), 
          
          // 2. Capa de Contenido (AQUÍ ES DONDE SE APLICA EL FIX)
          if (isAuthenticated)
            // SI ESTÁ LOGUEADO: Usamos el NavigationGateway como pantalla principal
            const NavigationGateway() 
          else
            // SI NO ESTÁ LOGUEADO: Usamos la pantalla de Login o Splash
            const Center(child: Text("Login Screen Placeholder", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}