import 'dart:async';
import 'package:flutter/material.dart';
import '../pixel_text.dart';
import '../../../../screens/chatbot_page.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  String dots = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 300), (t) {
      setState(() {
        dots = dots.length < 3 ? dots + "." : "";
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PixelText.bodyMedium(
      "El bot está escribiendo$dots",
      color: ChatbotPage.botMessageColor,
    );
  }
}
