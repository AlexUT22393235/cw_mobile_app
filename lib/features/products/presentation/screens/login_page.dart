import 'package:flutter/material.dart';

// Importaciones: utilidades HTTP y servicio de autenticación
import 'package:http/http.dart' as http; // Cliente HTTP para llamadas de red
import '/features/auth/data/auth_api.dart'; // Servicio de autenticación

// Importación: layout base reutilizable (BasicGeneralScreen)
import '../screens/general/basic_general_screen.dart';
// Importaciones: componentes UI reutilizables
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart';

// Declaración: tipo VoidCallback para callbacks de navegación
typedef VoidCallback = void Function();

class LoginPage extends StatefulWidget {
  // Callbacks: navegación e interacción con AppShell
  final VoidCallback
  onLoginRequested; // Callback: iniciar sesión y navegar a Home
  final VoidCallback onRegisterRequested; // Callback: navegar a Register

  const LoginPage({
    super.key,
    required this.onLoginRequested,
    required this.onRegisterRequested,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores de formulario
  late final TextEditingController _emailController; // Controlador para email
  late final TextEditingController _passwordController;

  // Estado: indicador de carga para operaciones asíncronas
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(); // Inicialización del controlador
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Lógica: función asíncrona de autenticación
  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Validación: notificar campos faltantes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa email y contraseña')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Marca inicio de operación asíncrona
    });

    try {
      // Paso 1: invocar servicio de autenticación (API)
      final result = await AuthApi().signIn(email, password);

      // Paso 2: éxito -> persistir token de forma segura (no mostrado aquí)
      print('Login Exitoso. Token: ${result['access_token']}');

      // Paso 3: notificar al AppShell para la navegación a la pantalla principal
      widget.onLoginRequested();
    } catch (e) {
      // Manejo de errores: mostrar mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Marca fin de operación asíncrona
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4);

    return BasicContentLayout(
      sectionTitleText: 'INICIA SESIÓN',

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // UI: campos del formulario (email, contraseña)
          // Campo: etiqueta 'EMAIL' para el identificador del usuario
          PixelTextField(labelText: 'EMAIL', controller: _emailController),
          const SizedBox(height: 15.0),
          PixelTextField(
            labelText: 'CONTRASEÑA',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 30.0),

          // UI: botón de envío
          // Dispara la lógica de autenticación; se deshabilita durante la carga
          PixelButton(
            text: _isLoading ? 'CONECTANDO...' : 'ENTRAR',
            onPressed: _isLoading
                ? null
                : _handleLogin, // Deshabilita si está cargando
          ),
          const SizedBox(height: 25.0),

          // UI: enlaces inferiores para navegación (Register)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PixelText.bodySmall('¿No tienes cuenta?', color: Colors.white70),
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : widget
                          .onRegisterRequested, // Deshabilitar si está cargando
                child: PixelText.bodySmall('REGÍSTRATE', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
