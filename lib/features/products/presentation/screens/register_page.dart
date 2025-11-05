import 'package:flutter/material.dart';

// Importación del layout genérico
import '../screens/general/basic_general_screen.dart'; 
// Importaciones de componentes de UI
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/common/text/pixel_text.dart'; 

// Definimos el tipo de función para los callbacks
typedef VoidCallback = void Function(); 

class RegisterPage extends StatefulWidget {
  // Callbacks requeridos para la maquetación interna del AppShell
  final VoidCallback onLoginRequested; // Enlace -> Volver a Login
  final VoidCallback onRegisterRequested; // Botón REGISTRARME (Maquetación)

  const RegisterPage({
    super.key,
    required this.onLoginRequested,
    required this.onRegisterRequested,
  });
  
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores (se mantienen para la maquetación)
  late final TextEditingController _usuarioController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usuarioController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color coldWarBlue = Color(0xFF33FFC4); 

    // Dado que AppShell ya tiene el Scaffold y el fondo transparente,
    // solo nos aseguramos de no agregar un fondo opaco aquí.
    return BasicContentLayout(
      sectionTitleText: 'REGÍSTRATE',
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Campos
          PixelTextField(labelText: 'NUEVO USUARIO', controller: _usuarioController),
          const SizedBox(height: 15.0),
          PixelTextField(labelText: 'CONTRASEÑA', obscureText: true, controller: _passwordController),
          const SizedBox(height: 15.0),
          PixelTextField(labelText: 'CONFIRMAR', obscureText: true, controller: _confirmPasswordController),
          const SizedBox(height: 30.0),

          // Botón REGISTRARME: Llama al callback de maquetación (por ahora, vacío)
          PixelButton(text: 'REGISTRARME', onPressed: widget.onRegisterRequested), 
          const SizedBox(height: 25.0),

          // Enlaces inferiores
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PixelText.bodySmall('¿Ya tienes cuenta?', color: Colors.white70),
              const SizedBox(width: 4.0),
              GestureDetector(
                // Llama al callback que le indica a AppShell que cambie a LoginPage
                onTap: widget.onLoginRequested, 
                child: PixelText.bodySmall('INICIA SESIÓN', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
