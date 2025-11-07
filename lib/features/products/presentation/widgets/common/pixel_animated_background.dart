import 'dart:math';
import 'package:flutter/material.dart';

// Modelo: datos de un copo pixelado (posición, tamaño, velocidad, color)
class PixelSnowflake {
  double x;
  double y;
  double size;
  double speed;
  Color color;

  PixelSnowflake(this.x, this.y, this.size, this.speed, this.color);
}

// Widget: fondo animado que renderiza y anima múltiples copos pixelados
class PixelAnimatedBackground extends StatefulWidget {
  final int numberOfSnowflakes;
  final Color baseColor; // Color principal del fondo
  final Color accentColor; // Color de los copos (turquesa)
  final double snowflakeMinSize;
  final double snowflakeMaxSize;
  final double snowflakeMinSpeed;
  final double snowflakeMaxSpeed;

  const PixelAnimatedBackground({
    Key? key,
  this.numberOfSnowflakes = 100, // Número de copos en la animación
  this.baseColor = const Color(0xFF1A1A2E), // Color de fondo por defecto
  this.accentColor = const Color(0xFF33FFC4), // Color de acento para copos
    this.snowflakeMinSize = 1.0,
    this.snowflakeMaxSize = 2.0,
    this.snowflakeMinSpeed = 0.5,
    this.snowflakeMaxSpeed = 2.0,
  }) : super(key: key);

  @override
  State<PixelAnimatedBackground> createState() => _PixelAnimatedBackgroundState();
}

class _PixelAnimatedBackgroundState extends State<PixelAnimatedBackground> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<PixelSnowflake> _snowflakes;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Inicializar la lista de copos con valores aleatorios
    _snowflakes = List.generate(widget.numberOfSnowflakes, (index) => _createSnowflake());

    // AnimationController: refresco aproximado a 60 FPS para animación continua
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ≈60 FPS
    )..addListener(() {
        _updateSnowflakes();
        setState(() {}); // Forzar repintado del CustomPainter
      })
      ..repeat(); // Ejecutar la animación de forma continua
  }

  // Genera un copo con atributos aleatorios dentro de los rangos configurados
  PixelSnowflake _createSnowflake() {
    return PixelSnowflake(
      _random.nextDouble() * 1.0, // Posición X relativa (0.0 a 1.0)
      _random.nextDouble() * 1.0, // Posición Y relativa (0.0 a 1.0)
      widget.snowflakeMinSize + (_random.nextDouble() * (widget.snowflakeMaxSize - widget.snowflakeMinSize)),
      widget.snowflakeMinSpeed + (_random.nextDouble() * (widget.snowflakeMaxSpeed - widget.snowflakeMinSpeed)),
      // Color: alternar entre blanco y color de acento para variación
      _random.nextBool() ? Colors.white : widget.accentColor.withOpacity(0.8),
    );
  }

  // Actualiza posiciones y resetea copos que salen del área visible
  void _updateSnowflakes() {
    for (var snowflake in _snowflakes) {
      snowflake.y += (snowflake.speed / 1000); // Mueve hacia abajo
      // Si el copo sale de la pantalla por abajo, resetearlo arriba con nueva posición/velocidad
      if (snowflake.y > 1.0) {
        snowflake.y = 0.0; // Vuelve arriba
        snowflake.x = _random.nextDouble() * 1.0; // Nueva posición X aleatoria
        snowflake.size = widget.snowflakeMinSize + (_random.nextDouble() * (widget.snowflakeMaxSize - widget.snowflakeMinSize));
        snowflake.speed = widget.snowflakeMinSpeed + (_random.nextDouble() * (widget.snowflakeMaxSpeed - widget.snowflakeMinSpeed));
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PixelSnowflakePainter(
        _snowflakes,
        widget.baseColor,
        MediaQuery.of(context).size, // Tamaño actual para cálculo de posiciones absolutas
      ),
      child: Container(), // Hijo vacío para ocupar el espacio del CustomPaint
    );
  }
}

// CustomPainter: renderiza copos sobre el canvas
class _PixelSnowflakePainter extends CustomPainter {
  final List<PixelSnowflake> snowflakes;
  final Color baseColor;
  final Size canvasSize; // Tamaño del área de dibujo (para convertir posiciones relativas)

  _PixelSnowflakePainter(this.snowflakes, this.baseColor, this.canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar fondo base con el color proporcionado
    final backgroundPaint = Paint()..color = baseColor;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // Renderizar cada copo transformando coordenadas relativas a absolutas
    for (var snowflake in snowflakes) {
      final paint = Paint()..color = snowflake.color;
      // Convertir posiciones relativas a absolutas
      final x = snowflake.x * canvasSize.width;
      final y = snowflake.y * canvasSize.height;
      // Dibujar un pequeño cuadrado (pixel)
      canvas.drawRect(Rect.fromLTWH(x, y, snowflake.size, snowflake.size), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint: verdadero porque la animación modifica continuamente los copos
    return true;
  }
}
