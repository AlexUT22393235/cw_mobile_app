// lib/features/auth/data/auth_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  // Asegúrate de usar la URL y puerto correctos
  static const String _baseUrl = 'http://localhost:8000/api/v1/auth';
  // NOTA: Usamos 10.0.2.2 si estás usando el emulador de Android 
  // (es el alias para 127.0.0.1/localhost del host machine). 
  // Si usas iOS/Chrome, usa http://localhost:8000.


  

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = Uri.parse('$_baseUrl/signin');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Verificación simple del estado HTTP
      if (response.statusCode == 200) {
        // Éxito: Decodifica el TokenOut (access_token, token_type)
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        // Fallo en la autenticación (Credenciales inválidas)
        throw Exception(jsonDecode(response.body)['detail'] ?? 'Credenciales inválidas o error desconocido.');
      } else {
        // Otros errores del servidor
        throw Exception('Error de servidor: Código ${response.statusCode}');
      }
    } catch (e) {
      // Error de red o conexión
      throw Exception('Fallo de conexión: $e');
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password, String displayName) async {
    final url = Uri.parse('$_baseUrl/signup');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'display_name': displayName, // <--- CAMPO CLAVE
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        // Fallo: Puede ser que el usuario ya exista o credenciales débiles
        throw Exception(jsonDecode(response.body)['detail'] ?? 'Error de registro.');
      } else {
        throw Exception('Error de servidor: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión o red: $e');
    }
  }

}