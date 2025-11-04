import 'package:flutter/material.dart';

// Importación del layout genérico
import '../screens/general/basic_general_screen.dart'; 

// Importaciones de los componentes que sí son específicos de Registro
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart';
// Eliminamos: text/styles/text_styles.dart (ya no es necesario)

class RegisterPage extends StatefulWidget {
  final VoidCallback onLoginRequested; 

  const RegisterPage({
    Key? key,
    required this.onLoginRequested,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _usuarioController;
  late final TextEditingController _correoController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usuarioController = TextEditingController();
    _correoController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El color coldWarBlue es necesario aquí para el enlace inferior.
    const Color coldWarBlue = Color(0xFF33FFC4);

    // Reemplazamos toda la estructura externa (SingleChildScrollView, Container, BoxDecoration)
    // por el layout modular BasicContentLayout.
    return BasicContentLayout(
      sectionTitleText: 'REGÍSTRATE', // Título de la sección
      
      // El 'content' es el Column con los campos y acciones específicas de Registro
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campo Usuario
          PixelTextField(
            labelText: 'USUARIO',
            controller: _usuarioController,
          ),
          const SizedBox(height: 15.0),

          // Campo Correo Electrónico
          PixelTextField(
            labelText: 'CORREO ELECTRÓNICO',
            keyboardType: TextInputType.emailAddress,
            controller: _correoController,
          ),
          const SizedBox(height: 15.0),

          // Campo Contraseña
          PixelTextField(
            labelText: 'CONTRASEÑA',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 15.0),

          // Campo Confirmar Contraseña
          PixelTextField(
            labelText: 'CONFIRMAR CONTRASEÑA',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 30.0),

          // Botón CREAR CUENTA
          PixelButton(
            text: 'CREAR CUENTA',
            onPressed: () {
              // Aquí se implementará la lógica de registro
            },
          ),
          const SizedBox(height: 25.0),

          // Enlace inferior (Volver a Login)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4.0,
            children: [
              PixelText.bodySmall(
                '¿Ya tienes cuenta?',
                color: Colors.white70,
              ),
              GestureDetector(
                onTap: widget.onLoginRequested,
                child: PixelText.bodySmall(
                  'INICIA SESIÓN',
                  color: coldWarBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}