import 'package:flutter/material.dart';
import '../common/text/pixel_text.dart';

class Lore1 extends StatelessWidget {
  const Lore1({super.key});

  // Constantes de estilo
  static const Color coldWarBlue = Color(0xFF33FFC4);
  
  // LOREM IPSUM para probar el scroll
  // Se usa triple comilla simple para facilitar la edición del texto y los saltos de línea.
  static const String _storyText = """
  Se cuenta en las crónicas grabadas en el hielo eterno, en un mundo quebrado y sanado tras la guerra de los antiguos seres, que la vida encontró un nuevo camino.

  Los constructores de metal y fuego desaparecieron en un cataclismo de su propia creación, dando paso a la Larga Noche y, finalmente, a la Era del Silencio Frío.
  """;
  
  static const String _storyText2 = """
  En los confines de este mundo renacido, donde el sol se aferra al cielo durante seis meses y lo abandona por otros seis, yace el Gran Polo Sur.

  Bajo esta luz perpetua, o en esta oscuridad absoluta, sobrevive la **Aldea de Pescadores**.
  
  Una aldea hogareña, humilde, con construcciones redondas completamente de hielo, hogar de focas, criaturas que hace mucho tiempo eran libres de nadar y pescar bajo grandes auroras boreales.
  """;

  static const String _storyText3 = """
  Pero dicha libertad solo es un recuerdo que los viejos mencionan; ahora esta palabra se desvanece en el cruel frío.

  El Polo Sur ya no conoce la libertad para cualquier ser vivo, desde que la **Ciudad del Hielo Puro** se ha levantado. Sus pingüinos extienden su reinado a cada rincón posible, liderado por un emperador cuyas leyes son más frías que el polo mismo. Sus legiones gobiernan con frío hierro.
  """;

  static const String _storyText4 = """
  En la aldea oprimida, una joven foca, tal vez un don nadie para el imperio, huérfano que no destaca de la multitud, **Snowy**, creció bajo el yugo del imperio, pero no nació para tener la cabeza inclinada. 
  
  Aun él lo desconoce, pero por su sangre corre sangre rebelde. Bajo su temor, late un corazón que puede derretir el hielo más puro, proveniente de un linaje tejido con honor y una esperanza que el Imperio creyó haber extinguido hacía generaciones.

  Así comienza la historia de un héroe…
  """;

  @override
  Widget build(BuildContext context) {
    // Usamos el ancho disponible para calcular un ancho máximo (ej. 70% de la pantalla)
    final double maxTextWidth = MediaQuery.of(context).size.width * 0.70;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // El texto comienza con una gran separación superior para simular que viene desde abajo
          const SizedBox(height: 500), 
          
          // === TÍTULO INICIAL ===
          PixelText.headline(
            'CAPÍTULO I: EL LEGADO DE CÁNOVAS',
            color: coldWarBlue,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          
          // === SECCIÓN 1 ===
          SizedBox(
            width: maxTextWidth, // Limitamos el ancho para el efecto de túnel
            child: PixelText.bodyLarge(
              _storyText,
              color: coldWarBlue,
              textAlign: TextAlign.center,
              height: 1.8, 
            ),
          ),
          const SizedBox(height: 40), // Separación visual entre párrafos
          
          // === SECCIÓN 2 ===
          SizedBox(
            width: maxTextWidth, 
            child: PixelText.bodyLarge(
              _storyText2,
              color: coldWarBlue,
              textAlign: TextAlign.center,
              height: 1.8, 
            ),
          ),
          const SizedBox(height: 40),
          
          // === SECCIÓN 3 ===
          SizedBox(
            width: maxTextWidth, 
            child: PixelText.bodyLarge(
              _storyText3,
              color: coldWarBlue,
              textAlign: TextAlign.center,
              height: 1.8, 
            ),
          ),
          const SizedBox(height: 40),

          // === SECCIÓN 4 (Protagonista) ===
          SizedBox(
            width: maxTextWidth, 
            child: PixelText.bodyLarge(
              _storyText4,
              color: coldWarBlue,
              textAlign: TextAlign.center,
              height: 1.8, 
            ),
          ),
          
          // === FINALIZACIÓN ===
          const SizedBox(height: 60),
          PixelText.bodyMedium(
            'Pulsa la pantalla para pausar el texto y leer con calma.',
            color: coldWarBlue.withOpacity(0.6),
            textAlign: TextAlign.center,
          ),
          
          // Gran espacio final para que el scroll llegue hasta arriba
          const SizedBox(height: 500),
        ],
      ),
    );
  }
}