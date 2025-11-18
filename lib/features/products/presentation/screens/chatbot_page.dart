// import 'package:flutter/material.dart';
// import 'package:pixelarticons/pixelarticons.dart';

// // Importación del layout genérico y componentes de UI
// import '../screens/general/basic_general_screen.dart';
// import '../widgets/common/pixel_text_field.dart';
// import '../widgets/common/pixel_button.dart';
// import '../widgets/chatbot/chat_message.dart'; 

// class ChatbotPage extends StatelessWidget {
//   const ChatbotPage({super.key});

//   static const Color coldWarBlue = Color(0xFF33FFC4);
//   static const Color userMessageColor = Colors.white;
//   static const Color botMessageColor = coldWarBlue;

//   @override
//   Widget build(BuildContext context) {
//     final double chatAreaHeight = MediaQuery.of(context).size.height * 0.45;

//     return BasicContentLayout(
//       sectionTitleText: 'CHATBOT',
      
//       content: Column(
//         mainAxisSize: MainAxisSize.min, 
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
          
//           // === Área de Mensajes (SizedBox con Altura Fija) ===
//           SizedBox(
//             height: chatAreaHeight, 
//             child: ListView(
//               shrinkWrap: true, 
//               reverse: true, 
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
              
//               children: const <Widget>[
//                 ChatMessage(
//                   text: 'Los enemigos a distancia tienen menos vida.',
//                   isUser: false, 
//                 ),
//                 ChatMessage(
//                   text: '¿Cómo le gano al jefe Orca?.',
//                   isUser: true, 
//                 ),
//                 ChatMessage(
//                   text: 'Ataca sus puntos débiles y usa cobertura.',
//                   isUser: false, 
//                 ),
//               ].reversed.toList(), 
//             ),
//           ),

//           // Separador visual
//           const Divider(color: coldWarBlue, height: 1.0, thickness: 1.0),
//           const SizedBox(height: 10.0),

//           // Área de Entrada de Texto y Botón
//           Row(
//             children: <Widget>[
//               // Campo de texto
//               const Expanded(
//                 child: PixelTextField(labelText: 'ESCRIBA SU MENSAJE...'),
//               ),
//               // 
//               const SizedBox(width: 2.0),
//               // Botón de Enviar
//               SizedBox(
                
//                 width: 48, 
//                 height: 48,
//                 child: PixelButton(
//                   icon: Pixel.arrowbarup,
//                   text: '', 
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:http/http.dart' as http;

import '../screens/general/basic_general_screen.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/chatbot/chat_message.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  static const Color coldWarBlue = Color(0xFF33FFC4);
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [
    const ChatMessage(text: 'Los enemigos a distancia tienen menos vida.', isUser: false),
    const ChatMessage(text: '¿Cómo le gano al jefe Orca?', isUser: true),
    const ChatMessage(text: 'Ataca sus puntos débiles y usa cobertura.', isUser: false),
  ];


  final String apiUrl = "http://localhost:8000/api/v1/chat/advice/public";

  Future<void> _sendMessage() async {
    final String userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: userText, isUser: true));
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String answer = data["answer"] ?? "No obtuve respuesta.";

        setState(() {
          _messages.add(ChatMessage(text: answer, isUser: false));
        });
      } else {
        setState(() {
          _messages.add(const ChatMessage(
            text: "⚠️ Error en el servidor",
            isUser: false,
          ));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(const ChatMessage(
          text: "No se pudo conectar con el servidor",
          isUser: false,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double chatAreaHeight = MediaQuery.of(context).size.height * 0.45;

    return BasicContentLayout(
      sectionTitleText: 'CHATBOT',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: chatAreaHeight,
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              children: _messages.reversed.toList(),
            ),
          ),

          const Divider(color: coldWarBlue, height: 1.0, thickness: 1.0),
          const SizedBox(height: 10.0),

          Row(
            children: <Widget>[
              Expanded(
                child: PixelTextField(
                  labelText: 'ESCRIBA SU MENSAJE...',
                  controller: _controller,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 2.0),
              SizedBox(
                width: 48,
                height: 48,
                child: PixelButton(
                  icon: Pixel.arrowbarup,
                  text: '',
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
