import 'package:flutter/material.dart';

// Importaciones del backend y HTTP
import 'package:http/http.dart' as http; // Necesario para SnackBar/Context si no está ya
import '/features/auth/data/auth_api.dart'; // <--- NUEVO: Servicio de API

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
  // Controladores
  late final TextEditingController _emailController; // CAMBIO: Usaremos email
  late final TextEditingController _passwordController;
  
  // Estado para la carga y deshabilitar el botón
  bool _isLoading = false; // <--- ESTADO DE CARGA

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(); // Inicialización
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // === FUNCIÓN DE AUTENTICACIÓN ASÍNCRONA ===
  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Muestra un error rápido si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa email y contraseña')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Iniciamos la carga
    });

    try {
      // 1. Llamar al servicio API para el login
      final result = await AuthApi().signIn(email, password);
      
      // 2. Éxito: (Normalmente aquí guardarías el token de forma segura)
      print('Login Exitoso. Token: ${result['access_token']}'); 
      
      // 3. Navegar a la pantalla principal (Llamamos al callback del AppShell)
      widget.onLoginRequested(); 
      
    } catch (e) {
      // 4. Mostrar error de autenticación o conexión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Detenemos la carga
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
          // Campos
          // ⚠️ CAMBIO DE ETIQUETA: Usamos 'EMAIL'
          PixelTextField(labelText: 'EMAIL', controller: _emailController), 
          const SizedBox(height: 15.0),
          PixelTextField(labelText: 'CONTRASEÑA', obscureText: true, controller: _passwordController),
          const SizedBox(height: 30.0),

          // Botón ENTRAR
          // Llama al handler del login y se deshabilita si está cargando
          PixelButton(
            text: _isLoading ? 'CONECTANDO...' : 'ENTRAR', 
            onPressed: _isLoading ? null : _handleLogin // Deshabilita si está cargando
          ), 
          const SizedBox(height: 25.0),

          // Enlaces inferiores
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PixelText.bodySmall('¿No tienes cuenta?', color: Colors.white70),
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: _isLoading ? null : widget.onRegisterRequested, // Deshabilitar si está cargando
                child: PixelText.bodySmall('REGÍSTRATE', color: coldWarBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}