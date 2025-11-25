import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixelarticons/pixelarticons.dart';

import '../screens/general/basic_general_screen.dart';
import '../widgets/common/pixel_text_field.dart';
import '../widgets/common/pixel_button.dart';
import '../widgets/chatbot/chat_message.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  static const Color coldWarBlue = Color(0xFF33FFC4);
  static const Color userMessageColor = Colors.white;
  static const Color botMessageColor = coldWarBlue;

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [];

  /// 👉 Endpoint público
  final String apiUrl = "http://10.10.49.52:8000/api/v1/chat/advice";

  /// 👉 Para usar login, cambia por:
  /// final String apiUrl = "http://localhost:8000/api/v1/chat/advice";

  String? authToken; // 👈 aquí pondrás tu token si usas login

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
        headers: {
          "Content-Type": "application/json",
          if (authToken != null) "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({"question": userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String answer = data["answer"] ?? "No recibí respuesta.";

        setState(() {
          _messages.add(ChatMessage(text: answer, isUser: false));
        });
      } else {
        setState(() {
          _messages.add(
            const ChatMessage(
              text: "⚠ Error del servidor",
              isUser: false,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(
          const ChatMessage(
            text: "❌ No se pudo conectar con el servidor",
            isUser: false,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double chatAreaHeight = MediaQuery.of(context).size.height * 0.45;

    return BasicContentLayout(
      sectionTitleText: 'CHATBOT',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: chatAreaHeight,
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: _messages.reversed.toList(),
            ),
          ),

          const Divider(color: ChatbotPage.coldWarBlue, height: 1),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: PixelTextField(
                  labelText: 'ESCRIBA SU MENSAJE...',
                  controller: _controller,
                  onSubmitted: (_) => _sendMessage(),  
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 48,
                height: 48,
                child: PixelButton(
                  icon: Pixel.arrowbarup,
                  text: '',
                  onPressed: _sendMessage,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
