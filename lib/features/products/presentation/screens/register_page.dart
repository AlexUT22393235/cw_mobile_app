import 'package:flutter/material.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';

class RegisterPage extends StatelessWidget {
  // Nota: Pasar 'onLoginRequested' podría ser un VoidCallback para navegar
  // de vuelta a la pantalla de Login, pero por ahora solo es maquetado.
  const RegisterPage({Key? key}) : super(key: key);

  // Widget para el texto de estilo pixelado (Reutilizado de LoginPage)
  Widget _buildPixelText(String text, {double fontSize = 16.0, Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'PixelFont', // Reemplazar con tu fuente real
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definiciones de estilo (Reutilizadas de LoginPage)
    const Color darkBackground = Color(0xFF1A1A2E); 
    const Color coldWarBlue = Color(0xFF33FFC4); 

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        // AppBar simple para simular un botón de regreso
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: coldWarBlue),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            // El "marco" o caja principal (Reutilizado)
            decoration: BoxDecoration(
              border: Border.all(color: coldWarBlue, width: 4.0),
              color: darkBackground.withOpacity(0.8),
            ),
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 400),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Título principal: COLDWAR (Reutilizado)
                _buildPixelText(
                  'COLDWAR',
                  fontSize: 48.0,
                  color: coldWarBlue,
                  fontWeight: FontWeight.bold,
                ),
                Container(height: 2.0, color: coldWarBlue, width: 150.0), // Subrayado
                const SizedBox(height: 30.0),

                // Título: REGISTRARSE
                _buildPixelText(
                  'CREAR CUENTA',
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 20.0),

                // Campo Correo Electrónico
                const PixelTextField(
                  labelText: 'CORREO tu_correo@dominio.com',
                ),
                const SizedBox(height: 15.0),

                // Campo Usuario
                const PixelTextField(
                  labelText: 'USUARIO tu_usuario',
                ),
                const SizedBox(height: 15.0),

                // Campo Contraseña
                const PixelTextField(
                  labelText: 'CONTRASEÑA ********',
                  obscureText: true,
                ),
                const SizedBox(height: 15.0),

                // Campo Confirmar Contraseña (Adicional para Registro)
                const PixelTextField(
                  labelText: 'CONFIRMAR ********',
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),

                // Botón REGISTRARME
                const PixelButton(
                  text: 'REGISTRARME',
                ),
                const SizedBox(height: 25.0),

                // Enlace inferior (Volver a Login)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPixelText(
                      '¿Ya tienes cuenta? ',
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                    // Texto INICIA SESIÓN con el color de énfasis
                    GestureDetector(
                      // Aquí iría la navegación de vuelta a Login
                      onTap: () {
                        // Ejemplo: Navigator.pop(context); 
                      },
                      child: _buildPixelText(
                        'INICIA SESIÓN',
                        fontSize: 14.0,
                        color: coldWarBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}