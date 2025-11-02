import 'package:flutter/material.dart';
import '../widgets/common/pixel_animated_background.dart';
import 'login_page.dart';
import 'register_page.dart';

// Enum para manejar el estado interno de la página de autenticación
enum AuthFlow { login, register }

class AuthShell extends StatefulWidget {
  const AuthShell({Key? key}) : super(key: key);

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  AuthFlow _currentScreen = AuthFlow.login;

  void _setAuthFlow(AuthFlow flow) {
    setState(() {
      _currentScreen = flow;
    });
  }

  // Métodos separados para los callbacks
  void _goToRegister() {
    _setAuthFlow(AuthFlow.register);
  }

  void _goToLogin() {
    _setAuthFlow(AuthFlow.login);
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case AuthFlow.login:
        return LoginPage(
          onRegisterRequested: _goToRegister, // Usa la referencia directa al método
        );
      case AuthFlow.register:
        return RegisterPage(
          onLoginRequested: _goToLogin, // Usa la referencia directa al método
        );
      default:
        return const Center(child: Text("Error de AuthFlow", style: TextStyle(color: Colors.red)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          const PixelAnimatedBackground(
            numberOfSnowflakes: 150,
            snowflakeMinSize: 1.5,
            snowflakeMaxSize: 2.5,
            snowflakeMinSpeed: 1.0,
            snowflakeMaxSpeed: 3.0,
          ),
          
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildCurrentScreen(),
            ),
          ),
        ],
      ),
    );
  }
}