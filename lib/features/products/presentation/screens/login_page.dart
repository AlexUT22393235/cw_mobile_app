import 'package:flutter/material.dart';

// Importación del layout genérico

import '../screens/general/basic_general_screen.dart';


import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart'; 


class LoginPage extends StatefulWidget {
  final VoidCallback onRegisterRequested;

  const LoginPage({Key? key, required this.onRegisterRequested})
    : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usuarioController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usuarioController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El color coldWarBlue es necesario aquí para el enlace de "REGÍSTRATE"
    const Color coldWarBlue = Color(0xFF33FFC4); 

    // Reemplazamos toda la estructura externa por el layout modular
    return BasicContentLayout(
      sectionTitleText: 'INICIA SESIÓN',
      
      // El 'content' es el Column que contiene los campos y acciones
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campo Usuario
          PixelTextField(
            labelText: 'USUARIO',
            controller: _usuarioController,
          ),
          const SizedBox(height: 15.0),

          // Campo Contraseña
          PixelTextField(
            labelText: 'CONTRASEÑA',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 30.0),

          // Botón ENTRAR
          PixelButton(
            text: 'ENTRAR',
            onPressed: () {
              // Lógica de autenticación
            },
          ),
          const SizedBox(height: 25.0),

          // Enlaces inferiores
          Column(
            children: [
              PixelText.bodySmall(
                '¿Olvidaste tu contraseña?',
                color: Colors.white70,
              ),
              const SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  PixelText.bodySmall(
                    '¿No tienes cuenta?',
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onRegisterRequested,
                    child: PixelText.bodySmall(
                      'REGÍSTRATE',
                      color: coldWarBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}