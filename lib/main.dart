import 'package:flutter/material.dart';
// Importaciones: AppShell — capa de fondo animado y navegación principal
import 'features/products/presentation/widgets/common/app_shell.dart';
import 'features/products/presentation/widgets/common/text/styles/text_styles.dart';

// Nota: la importación de LoginPage se gestiona dentro de AppShell
// import 'features/products/presentation/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColdWar App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PressStart2P',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: PixelTextStyles.display,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: PixelTextStyles.headline,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: PixelTextStyles.title,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: PixelTextStyles.extraLarge,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontSize: PixelTextStyles.large,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: PixelTextStyles.medium,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(fontSize: PixelTextStyles.medium),
          titleSmall: TextStyle(fontSize: PixelTextStyles.small),
          bodyLarge: TextStyle(fontSize: PixelTextStyles.large),
          bodyMedium: TextStyle(fontSize: PixelTextStyles.medium),
          bodySmall: TextStyle(fontSize: PixelTextStyles.small),
          labelLarge: TextStyle(fontSize: PixelTextStyles.extraLarge),
          labelSmall: TextStyle(fontSize: PixelTextStyles.extraSmall),
        ),
      ),
      // Inicialización: AppShell como raíz de la aplicación (gestiona estados Auth/Main)
      home: const AppShell(),
    );
  }
}
