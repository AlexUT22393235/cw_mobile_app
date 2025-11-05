import 'package:flutter/material.dart';

// Importación del layout general
import '../screens/general/basic_general_screen.dart'; 
// Importación del contenido del Lore
import '../widgets/lore/lore_1.dart';
// Importación de texto modular
import '../widgets/common/text/pixel_text.dart'; 

class LorePage extends StatefulWidget {
  const LorePage({super.key});

  @override
  State<LorePage> createState() => _LorePageState();
}

class _LorePageState extends State<LorePage> with SingleTickerProviderStateMixin {
  
  // Constantes de estilo
  static const Color coldWarBlue = Color(0xFF33FFC4);
  
  // Controlador de scroll para mover el texto
  final ScrollController _scrollController = ScrollController();
  
  // Estado de la animación (simplificado)
  bool _isPaused = false;
  
  // Duración de la animación (ajustable)
  static const Duration _scrollDuration = Duration(seconds: 80); 
  
  // Referencia al futuro, usada para reanudar
  Future<void>? _scrollAnimationFuture; 

  // Función principal para iniciar/reanudar el scroll
  void _startOrResumeScroll() {
    if (!_scrollController.hasClients) return;
    
    final double maxScroll = _scrollController.position.maxScrollExtent;
    
    // Si ya estamos al final o no hay contenido para scrollear, salimos.
    if (_scrollController.offset >= maxScroll) return;

    // Calculamos la duración restante para mantener la velocidad
    final double currentOffset = _scrollController.offset;
    final double remainingDistance = maxScroll - currentOffset;
    final double totalDistance = maxScroll;

    // Evitamos la división por cero si el contenido es muy pequeño
    final double remainingTimeRatio = (totalDistance > 0) ? remainingDistance / totalDistance : 1.0;
    final Duration remainingDuration = _scrollDuration * remainingTimeRatio;

    // Almacenamos el Future para poder detenerlo más tarde
    _scrollAnimationFuture = _scrollController.animateTo(
      maxScroll,
      duration: remainingDuration,
      curve: Curves.linear,
    );
  }

  // Función para pausar/reanudar al tocar
  void _togglePause() {
    // 1. Invertir el estado de pausa
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      // 2. DETENER: Si está pausado, detenemos la animación saltando a la posición actual.
      // Esta es la corrección crucial de la línea 60.
      if (_scrollController.hasClients) {
         _scrollController.jumpTo(_scrollController.offset); 
      }
    } else {
      // 3. REANUDAR: Si se reanuda, volvemos a llamar a la función de scroll.
      _startOrResumeScroll();
    }
  }

  @override
  void initState() {
    super.initState();
    // Iniciamos la animación
    WidgetsBinding.instance.addPostFrameCallback((_) => _startOrResumeScroll());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BasicContentLayout(
      sectionTitleText: 'LORE', 
      
      content: Stack(
        children: [
          // Área de Scroll Principal
          GestureDetector(
            onTap: _togglePause, // Siempre se puede tocar para pausar/reanudar
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.65, // Altura visible
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                // Permitimos el scroll manual si está en pausa (o si ya terminó)
                physics: _isPaused 
                    ? const AlwaysScrollableScrollPhysics() 
                    : const NeverScrollableScrollPhysics(), // Bloquea durante la animación
                
                child: const Lore1(), 
              ),
            ),
          ),

          // ⚠️ CORRECCIÓN: Indicador de Pausa No Invasiva (en la esquina inferior derecha)
          if (_isPaused)
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: coldWarBlue.withOpacity(0.8),
                  border: Border.all(color: coldWarBlue),
                ),
                child: PixelText.bodySmall(
                  'PAUSA (Click para continuar)',
                  color: Colors.black, // Texto oscuro sobre el fondo azul
                ),
              ),
            ),
        ],
      ),
    );
  }
}