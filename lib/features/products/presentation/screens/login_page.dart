import 'package:flutter/material.dart';

// Importación del layout genérico
import '../screens/general/basic_general_screen.dart'; 
// Importaciones de componentes de UI
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart'; 

// Definimos el tipo de función para los callbacks
typedef VoidCallback = void Function(); 

class LoginPage extends StatefulWidget {
  // Callbacks requeridos para la maquetación interna del AppShell
  final VoidCallback onLoginRequested; // Botón ENTRAR -> Ir a Home
  final VoidCallback onRegisterRequested; // Enlace -> Ir a Register

  const LoginPage({
    super.key,
    required this.onLoginRequested,
    required this.onRegisterRequested,
  });
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores (se mantienen para la maquetación)
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

  // Las funciones de navegación desaparecen, ya que se usa el callback del widget

  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4); 

    return BasicContentLayout(
      sectionTitleText: 'INICIA SESIÓN',
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campos
          PixelTextField(labelText: 'USUARIO', controller: _usuarioController),
          const SizedBox(height: 15.0),
          PixelTextField(labelText: 'CONTRASEÑA', obscureText: true, controller: _passwordController),
          const SizedBox(height: 30.0),

          // Botón ENTRAR
          // Llama al callback que le indica a AppShell que cambie a HomePage
          PixelButton(text: 'ENTRAR', onPressed: widget.onLoginRequested), 
          const SizedBox(height: 25.0),

          // Enlaces inferiores
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PixelText.bodySmall('¿No tienes cuenta?', color: Colors.white70),
              const SizedBox(width: 4.0),
              GestureDetector(
                // Llama al callback que le indica a AppShell que cambie a RegisterPage
                onTap: widget.onRegisterRequested, 
                child: PixelText.bodySmall('REGÍSTRATE', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
