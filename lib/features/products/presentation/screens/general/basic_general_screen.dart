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

  // Espacio vertical que queremos dejar en la parte superior del marco
  static const double _topMarginSpace = 48.0; 
  // Padding lateral consistente
  static const double _horizontalPadding = 24.0; 
  static const double _verticalPadding = 24.0; 

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para obtener las restricciones de altura disponibles.
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usamos el SingleChildScrollView para manejar el desbordamiento en pantallas pequeñas
        return SingleChildScrollView(
          // CRUCIAL: Añadimos AlwaysScrollableScrollPhysics para centrar contenido corto.
          physics: const AlwaysScrollableScrollPhysics(),
          
          // === Padding Externo Ajustado ===
          padding: const EdgeInsets.only(
            top: _topMarginSpace, // Margen superior del marco (48.0)
            left: _horizontalPadding,
            right: _horizontalPadding,
            bottom: _verticalPadding, // Margen inferior del marco (24.0)
          ),
          
          // CRUCIAL: Usamos ConstrainedBox para forzar que el contenido ocupe
          // al menos la altura restante del área del SingleChildScrollView.
          child: ConstrainedBox(
            // La altura mínima es la altura disponible menos el padding vertical total
            // (top + bottom) que está fuera del marco de la tarjeta.
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - (_topMarginSpace + _verticalPadding),
            ),
            child: Center(
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
            ),
          ),
        );
      },
    );
  }
}