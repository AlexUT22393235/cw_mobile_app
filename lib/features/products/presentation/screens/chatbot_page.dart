import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';

// Importación del layout genérico y componentes de UI
import '../screens/general/basic_general_screen.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/chatbot/chat_message.dart'; 
import '../widgets/common/text/pixel_text.dart'; 

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  static const Color coldWarBlue = Color(0xFF33FFC4);
  static const Color userMessageColor = Colors.white;
  static const Color botMessageColor = coldWarBlue;

  @override
  Widget build(BuildContext context) {
    // Definimos la altura del área de mensajes usando el 45% del espacio vertical disponible.
    final double chatAreaHeight = MediaQuery.of(context).size.height * 0.45;

    // Reutilizamos BasicContentLayout
    return BasicContentLayout(
      sectionTitleText: 'CHATBOT',
      
      content: Column(
        // Cambiamos a mainAxisSize.min para ajustarnos a BasicContentLayout
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          
          // === Área de Mensajes (SizedBox con Altura Fija) ===
          SizedBox(
            height: chatAreaHeight, // Altura fija para evitar el error de Expanded
            child: ListView(
              // shrinkWrap: true asegura que el ListView solo ocupe la altura del SizedBox
              shrinkWrap: true, 
              reverse: true, 
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              
              children: const <Widget>[
                // Mensajes de EJEMPLO (Usando el widget modular ChatMessage)
                ChatMessage(
                  text: 'Hemos detectado actividad anómala en la red de comunicaciones. ¿Cuál es su estado actual?',
                  isUser: false, 
                ),
                ChatMessage(
                  text: 'Mi estado es OPERACIONAL. Enviando informe de anomalía.',
                  isUser: true, 
                ),
                ChatMessage(
                  text: 'Protocolo ZETA activado. Espere nuevas instrucciones.',
                  isUser: false, 
                ),
              ].reversed.toList(), 
            ),
          ),

          // Separador visual
          const Divider(color: coldWarBlue, height: 1.0, thickness: 1.0),
          const SizedBox(height: 10.0),

          // Área de Entrada de Texto y Botón
          Row(
            children: <Widget>[
              // Campo de texto
              const Expanded(
                child: PixelTextField(labelText: 'ESCRIBA SU MENSAJE...'),
              ),
              const SizedBox(width: 8.0),
              // Botón de Enviar
              SizedBox(
                width: 50,
                height: 50,
                child: PixelButton(
                  icon: Pixel.arrowbarup, // Asumiendo que PixelButton acepta 'icon'
                  text: '', 
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}