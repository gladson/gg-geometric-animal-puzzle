import 'package:flutter/material.dart';
import '../game/models/puzzle_piece.dart';

abstract class Animal {
  // Nome do animal
  String get name;

  // Nível de dificuldade
  int get difficulty;

  // Cor de fundo sugerida para o animal
  Color get backgroundColor;

  // Peças que compõem o animal
  List<PuzzlePiece> generatePieces();
}

// Classe auxiliar para definir cores vibrantes para crianças
class AnimalColors {
  static const Color catColor = Color(0xFFE91E63); // Rosa
  static const Color dogColor = Color(0xFF2196F3); // Azul
  static const Color elephantColor = Color(0xFF9C27B0); // Roxo
  static const Color lionColor = Color(0xFFFF9800); // Laranja
  static const Color rabbitColor = Color(0xFF4CAF50); // Verde

  // Cores de destaque
  static const Color highlight1 = Color(0xFFFFEB3B); // Amarelo
  static const Color highlight2 = Color(0xFF00BCD4); // Ciano
  static const Color highlight3 = Color(0xFFFF5722); // Laranja escuro
  static const Color highlight4 = Color(0xFF8BC34A); // Verde limão
  static const Color highlight5 = Color(0xFFFF4081); // Rosa escuro
}
