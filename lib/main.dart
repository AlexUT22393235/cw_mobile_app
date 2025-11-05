import 'package:flutter/material.dart';
// Importamos el Shell que maneja el fondo animado y la navegación principal
import 'features/products/presentation/widgets/common/app_shell.dart'; 
import 'features/products/presentation/widgets/common/text/styles/text_styles.dart';

// Eliminamos la importación de login_page.dart ya que AppShell la maneja.
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
      // Establecemos AppShell como la raíz, eliminando los errores de argumentos de LoginPage
      home: const AppShell(),
    );
  }
}
