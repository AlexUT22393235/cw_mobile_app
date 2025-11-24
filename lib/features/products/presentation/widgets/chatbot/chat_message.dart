import 'package:flutter/material.dart';
import '../common/text/pixel_text.dart';
import '../../screens/chatbot_page.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.70;

    final bubbleColor =
        isUser ? ChatbotPage.userMessageColor : ChatbotPage.botMessageColor;

    final alignment =
        isUser ? Alignment.centerRight : Alignment.centerLeft;

    if (text == "___typing___") {
      return Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: const Text(
          "Escribiendo...",
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 12,
            color: ChatbotPage.botMessageColor,
          ),
        ),
      );
    }

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: bubbleColor, width: 1.5),
        ),
        child: PixelText.bodyMedium(
          text,
          color: bubbleColor,
        ),
      ),
    );
  }
}
