import 'package:flutter/material.dart';

// Importaciones: componentes base reutilizables (marco y títulos)
import '../../widgets/common/pixel_frame_card.dart';
import '../../widgets/common/titles/application_title.dart';
import '../../widgets/common/titles/section_title.dart';

// Layout: wrapper básico reutilizable para pantallas de autenticación y secciones
class BasicContentLayout extends StatelessWidget {
  // Propiedad: título de sección (ej. 'INICIA SESIÓN')
  final String sectionTitleText;
  // Propiedad: contenido dinámico (campos, botones y enlaces)
  final Widget content;

  const BasicContentLayout({
    super.key,
    required this.sectionTitleText,
    required this.content,
  });

  // Constantes: márgenes y paddings utilizados por el layout
  static const double _topMarginSpace = 48.0;
  static const double _horizontalPadding = 24.0;
  static const double _verticalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    // Diseño: usar LayoutBuilder para obtener restricciones de altura disponibles
    return LayoutBuilder(
      builder: (context, constraints) {
        // Uso de SingleChildScrollView para manejar desbordamiento en pantallas pequeñas
        return SingleChildScrollView(
          // Physics: AlwaysScrollable para permitir centrar contenido corto
          physics: const AlwaysScrollableScrollPhysics(),

          // === Padding Externo Ajustado ===
          padding: const EdgeInsets.only(
            top: _topMarginSpace, // Margen superior del marco (48.0)
            left: _horizontalPadding,
            right: _horizontalPadding,
            bottom: _verticalPadding, // Margen inferior del marco (24.0)
          ),

          // ConstrainedBox: asegurar que el contenido ocupe al menos la altura disponible
          child: ConstrainedBox(
            // La altura mínima = altura disponible - padding vertical total (top + bottom)
            constraints: BoxConstraints(
              minHeight:
                  constraints.maxHeight - (_topMarginSpace + _verticalPadding),
            ),
            child: Center(
              // 1. El marco que se adapta al contenido (PixelFrameCard)
              child: PixelFrameCard(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Ajusta el tamaño al contenido
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
