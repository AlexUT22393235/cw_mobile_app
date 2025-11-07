import 'package:flutter/material.dart';

// Importaciones del backend
import '/features/auth/data/auth_api.dart'; 
import 'dart:async'; // Necesario para Future y async

// Importación: layout base reutilizable (BasicGeneralScreen)
import '../screens/general/basic_general_screen.dart';
// Importaciones de componentes de UI
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart';
import 'package:pixelarticons/pixelarticons.dart'; // [técnico] Necesario para los iconos de visibilidad

// Declaración: tipos de callback usados por este formulario
typedef VoidCallback = void Function();

class RegisterPage extends StatefulWidget {
  // Callbacks requeridos para la maquetación interna del AppShell
  final VoidCallback onLoginRequested; // Enlace -> Volver a Login
  final VoidCallback onRegisterRequested; // Botón REGISTRARME (Callback para el AppShell)

  const RegisterPage({
    super.key,
    required this.onLoginRequested,
    required this.onRegisterRequested,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // [técnico] Controladores para los campos que requiere el backend: email, password, display_name.
  late final TextEditingController _emailController; 
  late final TextEditingController _displayNameController; 
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isLoading = false; // [técnico] Estado de carga de operación asíncrona.
  
  // [técnico] Variables de estado para la visibilidad de las contraseñas.
  bool _obscurePassword = true; 
  bool _obscureConfirmPassword = true; 

  // [técnico] Expresiones regulares para validación en el cliente.
  static const String _emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String _xssRegex = r'[<>]+'; // Patrón simple de prevención de scripts.

  @override
  void initState() {
    super.initState();
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

  // [técnico] Helper para mostrar SnackBar de error de forma consistente.
  void _showError(String message) {
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.shade900,
        ),
      );
  }

  // 2. FUNCIÓN DE REGISTRO ASÍNCRONA (con validaciones)
  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final displayName = _displayNameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // === VALIDACIONES DEL CLIENTE ===
    
    // 1. Campos Vacíos
    if (email.isEmpty || password.isEmpty || displayName.isEmpty || confirmPassword.isEmpty) {
      _showError('Todos los campos son obligatorios.');
      return;
    }
    
    // 2. Contraseña y Confirmación
    if (password.length < 6) {
      _showError('La contraseña debe tener al menos 6 caracteres.');
      return;
    }
    if (password != confirmPassword) {
      _showError('Las contraseñas no coinciden.');
      return;
    }
    
    // 3. Email
    if (!RegExp(_emailRegex).hasMatch(email)) {
      _showError('El formato del Email es incorrecto.');
      return;
    }
    
    // 4. Display Name (Prevención básica de scripts)
    if (RegExp(_xssRegex).hasMatch(displayName)) {
       _showError('El nombre de usuario contiene caracteres inválidos.');
       return;
    }

    setState(() { _isLoading = true; });

    try {
      // Llamar al servicio API (la estructura del JSON body es correcta en AuthApi)
      await AuthApi().signUp(email, password, displayName);
      
      // Registro Exitoso: Navegar al Login
      widget.onLoginRequested(); 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro completado. ¡Inicia sesión!'),
          backgroundColor: Color(0xFF33FFC4),
        ),
      );
      
    } catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      
      // Manejo de error de conexión específico
      if (errorMessage.contains("Fallo de conexión") || errorMessage.contains("Error de servidor") || errorMessage.contains("SocketException")) {
        errorMessage = "Lo sentimos, hay errores de conexión. Intenta más tarde.";
      }
      
      _showError(errorMessage);
    } finally {
      setState(() { _isLoading = false; });
    }
  }


  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4); 

    // [técnico] Helper para construir el ícono de alternancia de visibilidad.
    Widget _buildToggleIcon(bool isObscure, VoidCallback onTapHandler) {
      return GestureDetector(
        // ⚠️ CORRECCIÓN CLAVE: El onTapHandler ahora gestiona la alternancia
        // La alternancia debe ser llamada por el GestureDetector que envuelve el ícono
        onTap: onTapHandler,
        child: Icon(
          isObscure ? Pixel.eyeclosed : Pixel.eye, // Íconos de pixelarticons
          color: coldWarBlue,
          size: 20,
        ),
      );
    }

    return BasicContentLayout(
      sectionTitleText: 'REGÍSTRATE',
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campos
          PixelTextField(labelText: 'EMAIL', controller: _emailController), 
          const SizedBox(height: 15.0),
          PixelTextField(labelText: 'USUARIO', controller: _displayNameController),
          const SizedBox(height: 15.0),
          
          // Contraseña
          PixelTextField(
            labelText: 'CONTRASEÑA', 
            obscureText: _obscurePassword,
            controller: _passwordController,
            // ⚠️ USO CORREGIDO: Pasamos la función de alternancia directamente
            suffixIcon: _buildToggleIcon(_obscurePassword, () {
              setState(() { _obscurePassword = !_obscurePassword; });
            }),
          ),
          const SizedBox(height: 15.0),
          
          // Confirmar Contraseña
          PixelTextField(
            labelText: 'CONFIRMAR',
            obscureText: _obscureConfirmPassword,
            controller: _confirmPasswordController,
            // ⚠️ USO CORREGIDO: Pasamos la función de alternancia directamente
            suffixIcon: _buildToggleIcon(_obscureConfirmPassword, () {
              setState(() { _obscureConfirmPassword = !_obscureConfirmPassword; });
            }),
          ),
          const SizedBox(height: 30.0),

          // Botón REGISTRARME
          FittedBox( 
            fit: BoxFit.scaleDown,
            child: PixelButton(
              text: _isLoading ? 'REGISTRANDO...' : 'REGISTRARME',
              onPressed: _isLoading ? null : _handleRegister,
            ), 
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
                onTap: _isLoading ? null : widget.onLoginRequested,
                child: PixelText.bodySmall('INICIA SESIÓN', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}