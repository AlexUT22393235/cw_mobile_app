import 'dart:math';
import 'package:flutter/material.dart';

// Clase para representar un solo 'copo de nieve' pixelado
class PixelSnowflake {
  double x;
  double y;
  double size;
  double speed;
  Color color;

  PixelSnowflake(this.x, this.y, this.size, this.speed, this.color);
}

// Widget que dibuja y anima los copos de nieve
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
    this.numberOfSnowflakes = 100, // Cantidad de estrellas/copos
    this.baseColor = const Color(0xFF1A1A2E), // Fondo oscuro
    this.accentColor = const Color(0xFF33FFC4), // Color de los "copos"
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
    // Inicializar los copos de nieve
    _snowflakes = List.generate(widget.numberOfSnowflakes, (index) => _createSnowflake());

    // Configurar el controlador de animación para refrescar el UI
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // Aprox. 60 FPS
    )..addListener(() {
        _updateSnowflakes();
        setState(() {}); // Redibujar el CustomPainter
      })
      ..repeat(); // Repetir la animación indefinidamente
  }

  // Crea un copo de nieve con valores aleatorios
  PixelSnowflake _createSnowflake() {
    return PixelSnowflake(
      _random.nextDouble() * 1.0, // Posición X relativa (0.0 a 1.0)
      _random.nextDouble() * 1.0, // Posición Y relativa (0.0 a 1.0)
      widget.snowflakeMinSize + (_random.nextDouble() * (widget.snowflakeMaxSize - widget.snowflakeMinSize)),
      widget.snowflakeMinSpeed + (_random.nextDouble() * (widget.snowflakeMaxSpeed - widget.snowflakeMinSpeed)),
      // Alternar entre blanco y el color de acento
      _random.nextBool() ? Colors.white : widget.accentColor.withOpacity(0.8),
    );
  }

  // Actualiza la posición de cada copo de nieve
  void _updateSnowflakes() {
    for (var snowflake in _snowflakes) {
      snowflake.y += (snowflake.speed / 1000); // Mueve hacia abajo
      // Si el copo sale de la pantalla por abajo, lo resetea arriba
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
      child: Container(), // Un contenedor vacío como hijo para que ocupe espacio
    );
  }
}

// CustomPainter para dibujar los copos de nieve
class _PixelSnowflakePainter extends CustomPainter {
  final List<PixelSnowflake> snowflakes;
  final Color baseColor;
  final Size canvasSize; // Tamaño del área de dibujo

  _PixelSnowflakePainter(this.snowflakes, this.baseColor, this.canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar el fondo base (azul oscuro)
    final backgroundPaint = Paint()..color = baseColor;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // Dibujar cada copo de nieve
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
    // Siempre repintar porque los copos se están moviendo
    return true;
  }
}
