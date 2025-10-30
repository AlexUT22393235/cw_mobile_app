import 'package:flutter/material.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Widget para el texto de estilo pixelado
  Widget _buildPixelText(String text, {double fontSize = 16.0, Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
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
    // Color de fondo oscuro de la referencia
    const Color darkBackground = Color(0xFF1A1A2E); 
    const Color coldWarBlue = Color(0xFF33FFC4); // Color turquesa

    return Scaffold(
      backgroundColor: darkBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            // El "marco" o caja principal
            decoration: BoxDecoration(
              border: Border.all(color: coldWarBlue, width: 4.0),
              color: darkBackground.withOpacity(0.8), // Ligero contraste con el fondo
            ),
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 400),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Título principal: COLDWAR
                _buildPixelText(
                  'COLDWAR',
                  fontSize: 48.0,
                  color: coldWarBlue,
                  fontWeight: FontWeight.bold,
                ),
                Container(height: 2.0, color: coldWarBlue, width: 150.0), // Subrayado
                const SizedBox(height: 30.0),

                // Título: INICIA SESIÓN
                _buildPixelText(
                  'INICIA SESIÓN',
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 20.0),

                // Campo Usuario
                PixelTextField(
                  labelText: 'USUARIO tu_usuario',
                ),
                const SizedBox(height: 15.0),

                // Campo Contraseña
                PixelTextField(
                  labelText: 'CONTRASEÑA ********',
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),

                // Botón ENTRAR
                const PixelButton(
                  text: 'ENTRAR',
                ),
                const SizedBox(height: 25.0),

                // Enlaces inferiores (Olvido de contraseña y Registro)
                Column(
                  children: [
                    _buildPixelText(
                      '¿Olvidaste tu contraseña?',
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPixelText(
                          '¿No tienes cuenta? ',
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                        // Texto REGÍSTRATE con el color de énfasis
                        GestureDetector(
                          // Aquí iría la navegación a la pantalla de registro
                          child: _buildPixelText(
                            'REGÍSTRATE',
                            fontSize: 14.0,
                            color: coldWarBlue,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}