import 'package:flutter/material.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart'; // Importa el nuevo widget
import '../widgets/common/text/styles/text_styles.dart'; // Importa los estilos

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
    const Color darkBackground = Color(0xFF1A1A2E);
    const Color coldWarBlue = Color(0xFF33FFC4);

    return SingleChildScrollView(
      key: const ValueKey('LoginContent'),
      padding: const EdgeInsets.all(24.0),

      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: coldWarBlue, width: 4.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(4.0),

        child: Container(
          decoration: BoxDecoration(
            color: darkBackground.withOpacity(0.85),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(maxWidth: 400),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Título principal: COLDWAR
              PixelText.displayLarge('COLDWAR', color: coldWarBlue),
              Container(height: 2.0, color: coldWarBlue, width: 180.0),
              const SizedBox(height: 30.0),

              // Título: INICIA SESIÓN
              PixelText.titleLarge('INICIA SESIÓN', color: Colors.white),
              const SizedBox(height: 20.0),

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
        ),
      ),
    );
  }
}
