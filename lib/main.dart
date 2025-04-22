import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/puzzle_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Força a orientação retrato
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configura a interface do sistema para imersão total
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );

  runApp(const GeometricPuzzleApp());
}

class GeometricPuzzleApp extends StatelessWidget {
  const GeometricPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quebra-Cabeça de Animais Geométricos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Rounded', // Substitua por uma fonte amigável para crianças
        textTheme: const TextTheme(
          // Estilo de texto amigável para crianças
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: const PuzzleGame(),
    );
  }
}
