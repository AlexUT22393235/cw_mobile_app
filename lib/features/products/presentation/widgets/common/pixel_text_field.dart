import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  /// 👈 NUEVO: callback cuando se presiona ENTER
  final Function(String)? onSubmitted;

  const PixelTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onSubmitted, // 👈 se recibe aquí
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,

          /// 👈 NUEVO: cuando el usuario presione ENTER
          onSubmitted: onSubmitted,

          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'PressStart2P',
          ),
          decoration: InputDecoration(
            hintText: labelText.toUpperCase(),
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
              fontFamily: 'PressStart2P',
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),

            suffixIcon: suffixIcon,
            suffixIconConstraints:
                const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ),
      ),
    );
  }
}
