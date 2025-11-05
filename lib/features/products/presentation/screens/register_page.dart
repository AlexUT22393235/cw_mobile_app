import 'package:flutter/material.dart';

// Importaciones: módulos de backend y utilidades asíncronas
import '/features/auth/data/auth_api.dart';
import 'dart:async'; // Necesario para Future y async

// Importación: layout base reutilizable (BasicGeneralScreen)
import '../screens/general/basic_general_screen.dart';
// Importaciones de componentes de UI
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart';

// Declaración: tipos de callback usados por este formulario
typedef VoidCallback = void Function();

class RegisterPage extends StatefulWidget {
  // Callbacks requeridos para la maquetación interna del AppShell
  final VoidCallback onLoginRequested; // Enlace -> Volver a Login
  final VoidCallback
  onRegisterRequested; // Botón REGISTRARME (Callback para el AppShell)

  const RegisterPage({
    super.key,
    required this.onLoginRequested,
    required this.onRegisterRequested,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. CONTROLADORES Y ESTADO
  // El backend espera email, password y display_name.
  late final TextEditingController _emailController; // Corresponde a email
  late final TextEditingController
  _displayNameController; // Corresponde a display_name (anteriormente 'usuario')
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isLoading = false; // Estado de carga

  @override
  void initState() {
    super.initState();
    // Renombrado de controllers:
    _emailController = TextEditingController();
    _displayNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 2. FUNCIÓN DE REGISTRO ASÍNCRONA
  Future<void> _handleRegister() async {
    final email = _emailController.text;
    final displayName = _displayNameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validación mínima en el front
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }
    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Llamar al servicio API
      final result = await AuthApi().signUp(email, password, displayName);

      // Registro Exitoso: Se imprime el token (debería guardarse)
      print('Registro Exitoso. Token: ${result['access_token']}');

      // Navegar a la pantalla principal o de inicio de sesión
      // Usamos onLoginRequested para volver al Login y que el usuario inicie sesión
      widget.onLoginRequested();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro completado. ¡Inicia sesión!'),
          backgroundColor: Color(0xFF33FFC4),
        ),
      );
    } catch (e) {
      // Mostrar error del backend (ej: "El usuario ya existe" o "Contraseña débil")
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4);

    return BasicContentLayout(
      sectionTitleText: 'REGÍSTRATE',

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campos
          // ⚠️ CAMBIO: Email
          PixelTextField(labelText: 'EMAIL', controller: _emailController),
          const SizedBox(height: 15.0),
          // ⚠️ CAMBIO: Display Name
          PixelTextField(
            labelText: 'USUARIO',
            controller: _displayNameController,
          ),
          const SizedBox(height: 15.0),
          // Contraseñas
          PixelTextField(
            labelText: 'CONTRASEÑA',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 15.0),
          PixelTextField(
            labelText: 'CONFIRMAR',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 30.0),

          // Botón REGISTRARME: Llama a la lógica de la API
          PixelButton(
            text: _isLoading ? 'CREANDO USUARIO...' : 'REGISTRARME',
            onPressed: _isLoading ? null : _handleRegister,
          ),
          const SizedBox(height: 25.0),

          // Enlaces inferiores
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PixelText.bodySmall('¿Ya tienes cuenta?', color: Colors.white70),
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : widget.onLoginRequested, // Deshabilitar si carga
                child: PixelText.bodySmall('INICIA SESIÓN', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
