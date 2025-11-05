// Archivo: lib/widgets/chatbot/chat_message.dart

import 'package:flutter/material.dart';

// Importaciones necesarias
import '../common/text/pixel_text.dart'; 
import '../../screens/chatbot_page.dart'; // Para acceder a las constantes de color

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    // Alineación: derecha (usuario) o izquierda (bot)
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    // Color del texto, usando las constantes de ChatbotPage
    final color = isUser ? ChatbotPage.userMessageColor : ChatbotPage.botMessageColor;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280), // Limita el ancho de la burbuja
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // Borde con estilo pixel art
          border: Border.all(
            color: color, 
            width: 1.0,
          ),
        ),
        child: PixelText.bodyMedium(
          text,
          color: color,
        ),
      ),
    );
  }
}