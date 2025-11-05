// Archivo: lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import '../screens/general/basic_general_screen.dart'; 
import '../widgets/common/notifications/pixel_card_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  static const Color coldWarBlue = Color(0xFF33FFC4);
  
  final List<Map<String, dynamic>> _notifications = const [
    // ... Tus notificaciones de ejemplo ...
    {
      'title': 'NOVEDADES',
      'subtitle': 'Últimas apcticidades del juego',
      'borderColor': coldWarBlue,
    },
    {
      'title': 'MISIÓN DIARIA',
      'subtitle': 'Derota 5 Pingüinos Árticos',
      'borderColor': Colors.white,
    },
  ];

  Widget _buildPixelText(String text, {double fontSize = 16.0, Color color = Colors.white, FontWeight fontWeight = FontWeight.normal}) {
    // ... Tu implementación de texto ...
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'PressStart2P', 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Solo devolvemos el contenido
    return BasicContentLayout(
      sectionTitleText: 'INICIO',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 25.0),
          if (_notifications.isEmpty)
            // ... Mensaje de vacío ...
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: _buildPixelText(
                "Aún no hay notificaciones por mostrar :)",
                color: Colors.white54,
                fontSize: 14.0,
              ),
            )
          else
            // ... Lista de notificaciones ...
            ..._notifications.map((notification) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0), 
                child: PixelCardListItem(
                  title: notification['title']!,
                  subtitle: notification['subtitle']!,
                  borderColor: notification['borderColor']!,
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}