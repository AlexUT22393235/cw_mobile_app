import 'package:flutter/material.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart';
import '../widgets/common/text/styles/text_styles.dart';

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
    const Color darkBackground = Color(0xFF1A1A2E);
    const Color coldWarBlue = Color(0xFF33FFC4);

    return SingleChildScrollView(
      key: const ValueKey('RegisterContent'),
      padding: const EdgeInsets.all(16.0),
      
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
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Título principal: COLDWAR
              PixelText.displayLarge(
                'COLDWAR',
                color: coldWarBlue,
                
              ),
              Container(height: 2.0, color: coldWarBlue, width: 180.0),
              const SizedBox(height: 30.0),

              // Título: REGÍSTRATE
              PixelText.titleLarge(
                'REGÍSTRATE',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              
              // Campos de texto con sus controladores
              PixelTextField(
                labelText: 'USUARIO',
                controller: _usuarioController,
              ),
              const SizedBox(height: 15.0),

              PixelTextField(
                labelText: 'CORREO ELECTRÓNICO',
                keyboardType: TextInputType.emailAddress,
                controller: _correoController,
              ),
              const SizedBox(height: 15.0),

              PixelTextField(
                labelText: 'CONTRASEÑA',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 15.0),

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

              // Enlace inferior (Volver a Login) - USANDO WRAP PARA RESPONSIVE
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
        ),
      ),
    );
  }
}