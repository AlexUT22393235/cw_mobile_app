import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final IconData? icon;
  final Color color;

  static const Color _darkContrast = Color(0xFF1A1A2E);
  static const Color _lightContrast = Colors.white;

  const PixelButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = const Color(0xFF33FFC4),
    this.icon,
  }) : super(key: key);

  Color _getForegroundColor() {
    if (color == const Color(0xFF5FFB17) ||
        color == const Color(0xFFF91818) ||
        color == const Color(0xFF33FFC4)) {
      return _darkContrast;
    }
    return _lightContrast;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    final Color effectiveColor = isDisabled ? color.withOpacity(0.5) : color;
    final Color foregroundColor = _getForegroundColor();

    final bool isIconButton = text.isEmpty && icon != null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),

        decoration: BoxDecoration(
          color: effectiveColor,
          border: Border.all(color: foregroundColor, width: 2.0),
          borderRadius: BorderRadius.circular(3.0),
        ),

        padding: isIconButton
            ? const EdgeInsets.all(8.0)
            : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),

        alignment: Alignment.center,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: foregroundColor,
                size: isIconButton ? 22.0 : 18.0,
              ),

            if (icon != null && text.isNotEmpty)
              const SizedBox(width: 6.0),

            if (text.isNotEmpty)
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PressStart2P',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
