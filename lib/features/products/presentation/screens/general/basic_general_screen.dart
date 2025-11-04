import 'package:flutter/material.dart';

// Importación de los componentes base
import '../../widgets/common/pixel_frame_card.dart';
import '../../widgets/common/titles/application_title.dart';
import '../../widgets/common/titles/section_title.dart';

// Clase renombrada para reflejar que es un layout/wrapper básico y general
class BasicContentLayout extends StatelessWidget {
  // 1. Título dinámico de la sección (ej. 'INICIA SESIÓN')
  final String sectionTitleText;
  // 2. Contenido variable (campos, botones y enlaces)
  final Widget content;

  const BasicContentLayout({
    super.key,
    required this.sectionTitleText,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos el SingleChildScrollView para manejar el desbordamiento en pantallas pequeñas
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0), // Padding de la página
      
      // 1. El marco que se adapta al contenido (PixelFrameCard)
      child: PixelFrameCard(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
          children: <Widget>[
            // Título Principal Fijo
            const ApplicationTitle(titleText: 'COLDWAR'),

            // Título de la Sección (Variable: Login o Registro)
            SectionTitle(titleText: sectionTitleText),

            // Contenido Dinámico (Campos, Botones, Enlaces)
            content,
          ],
        ),
      ),
    );
  }
}