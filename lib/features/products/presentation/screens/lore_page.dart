import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart'; // Para los íconos de control

// Importación del layout general
import '../screens/general/basic_general_screen.dart'; 
// Importación del contenido del Lore
import '../widgets/lore/lore_1.dart';
// Importación de texto modular
import '../widgets/common/text/pixel_text.dart'; 
// Importación de botones
import '../widgets/common/pixel_button.dart'; 

class LorePage extends StatefulWidget {
  const LorePage({super.key});

  @override
  State<LorePage> createState() => _LorePageState();
}

class _LorePageState extends State<LorePage> with SingleTickerProviderStateMixin {
  
  // Constantes de estilo
  static const Color coldWarBlue = Color(0xFF33FFC4);
  // Definición de colores dinámicos
  static const Color playColor = Color(0xFF5FFB17); // Verde
  static const Color pauseColor = Color(0xFFF91818); // Rojo

  // Controlador de scroll para mover el texto
  final ScrollController _scrollController = ScrollController();
  
  bool _isAnimating = false; 
  bool _isPaused = false;
  
  // Duración de la animación (ajustable)
  static const Duration _scrollDuration = Duration(seconds: 80); 
  
  // Función para iniciar la animación (o reanudar)
  void _startAnimation() {
    if (!_scrollController.hasClients) return;
    
    setState(() {
      _isAnimating = true;
      _isPaused = false;
    });

    final double maxScroll = _scrollController.position.maxScrollExtent;
    
    // Si ya estamos al final, reiniciamos antes de animar
    if (_scrollController.offset >= maxScroll) {
      _resetScroll(); 
      // Usamos WidgetsBinding para asegurar que el jumpTo se complete antes de la animación
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateScroll(maxScroll, _scrollDuration);
      });
      return; 
    }

    _animateScroll(maxScroll, _scrollDuration);
  }

  // Helper para manejar la animación con duración restante
  void _animateScroll(double maxScroll, Duration totalDuration) {
    final double currentOffset = _scrollController.offset;
    final double remainingDistance = maxScroll - currentOffset;
    final double totalDistance = maxScroll;
    
    final double remainingTimeRatio = (totalDistance > 0) ? remainingDistance / totalDistance : 1.0;
    final Duration remainingDuration = totalDuration * remainingTimeRatio;

    _scrollController.animateTo(
      maxScroll,
      duration: remainingDuration,
      curve: Curves.linear,
    ).then((_) {
      setState(() {
        _isAnimating = false; // La animación ha terminado
        _isPaused = false;
      });
    });
  }
  
  // Función para reiniciar el scroll
  void _resetScroll() {
    if (!_scrollController.hasClients) return;

    // Detener cualquier animación en curso
    _scrollController.jumpTo(_scrollController.offset);
    
    // Mover el scroll al inicio inmediatamente
    _scrollController.jumpTo(0.0);

    setState(() {
      _isAnimating = false;
      _isPaused = false;
    });
  }


  // Función ÚNICA para manejar el botón principal (INICIAR/PAUSA/CONTINUAR)
  void _togglePause() {
    if (_isAnimating) {
      // ESTADO 1: Si está animando -> PAUSAR
      setState(() {
        _isPaused = true;
      });
      if (_scrollController.hasClients) {
         _scrollController.jumpTo(_scrollController.offset); // Detener animación
      }
    } else {
      // ESTADO 2: Si está pausado (o detenido) -> INICIAR/CONTINUAR
      _startAnimation();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // Lógica simplificada de estado: INICIAR o PAUSA
    final IconData playPauseIcon = _isAnimating ? Pixel.pause : Pixel.play;
    final Color buttonColor = _isAnimating ? pauseColor : playColor; // Solo cambia a rojo si está animando

    // El botón siempre dice INICIAR o PAUSA
    final String buttonText = _isAnimating ? 'PAUSA' : 'INICIAR';


    return BasicContentLayout(
      sectionTitleText: 'LORE', 
      
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // === CONTROLES DE BOTONES ===
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Botón INICIAR / PAUSA
                PixelButton(
                  icon: playPauseIcon,
                  text: buttonText,
                  onPressed: _togglePause,
                  color: buttonColor, // ✅ Consistente: Usamos 'color'
                ),
                const SizedBox(width: 10),
                
                // 2. Botón REINICIAR
                PixelButton(
                  icon: Pixel.reload, // ✅ Corregido: Usamos Pixel.refresh para el ícono
                  text: '',
                  onPressed: _resetScroll,
                  color: coldWarBlue, // ✅ Consistente: Usamos 'color'
                ),
              ],
            ),
          ),

          // === ÁREA DE SCROLL PRINCIPAL ===
          Stack(
            children: [
              GestureDetector(
                onTap: _togglePause, 
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.60,
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: _isAnimating
                        ? const NeverScrollableScrollPhysics() 
                        : const AlwaysScrollableScrollPhysics(), // Scroll manual liberado
                    
                    child: const Lore1(), 
                  ),
                ),
              ),

              // INDICADOR DE PAUSA NO INVASIVA
              if (_isPaused && _scrollController.hasClients && _scrollController.offset < _scrollController.position.maxScrollExtent)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: coldWarBlue.withOpacity(0.9),
                      border: Border.all(color: coldWarBlue),
                    ),
                    child: PixelText.bodySmall(
                      '',
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}