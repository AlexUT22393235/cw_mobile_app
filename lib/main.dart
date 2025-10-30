import 'package:flutter/material.dart';
import 'features/products/presentation/screens/login_page.dart';
import 'features/products/presentation/screens/register_page.dart';
import 'features/products/presentation/screens/home_page.dart';
 // Importa la nueva página
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColdWar Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Puedes definir la fuente 'PixelFont' aquí si la tienes importada
        // fontFamily: 'PixelFont', 
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      //home: const RegisterPage(), // Cambiado a RegisterPage para probar la nueva pantalla
      home: const HomePage(), // Cambiado a HomePage para probar la nueva pantalla
    );
  }
}