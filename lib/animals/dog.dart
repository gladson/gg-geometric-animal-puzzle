import 'package:flutter/material.dart';
import 'animal.dart';
import '../game/models/puzzle_piece.dart';

class Dog implements Animal {
  @override
  String get name => 'Cachorro';

  @override
  int get difficulty => 2; // Nível médio

  @override
  Color get backgroundColor => AnimalColors.dogColor.withValues(alpha: 0.2);

  @override
  List<PuzzlePiece> generatePieces() {
    List<PuzzlePiece> pieces = [];

    // Cabeça do cachorro (forma mais arredondada)
    pieces.add(PuzzlePiece(
      id: 1,
      name: 'Cabeça',
      color: AnimalColors.dogColor,
      points: [
        const Offset(0.3, 0.2),
        const Offset(0.45, 0.1),
        const Offset(0.6, 0.2),
        const Offset(0.65, 0.35),
        const Offset(0.5, 0.45),
        const Offset(0.35, 0.45),
        const Offset(0.25, 0.35),
      ],
    ));

    // Orelha esquerda (mais comprida que a do gato)
    pieces.add(PuzzlePiece(
      id: 2,
      name: 'Orelha Esquerda',
      color: AnimalColors.highlight2,
      points: [
        const Offset(0.25, 0.35),
        const Offset(0.3, 0.2),
        const Offset(0.15, 0.05),
        const Offset(0.1, 0.2),
      ],
    ));

    // Orelha direita (mais comprida que a do gato)
    pieces.add(PuzzlePiece(
      id: 3,
      name: 'Orelha Direita',
      color: AnimalColors.highlight2,
      points: [
        const Offset(0.65, 0.35),
        const Offset(0.6, 0.2),
        const Offset(0.85, 0.05),
        const Offset(0.9, 0.2),
      ],
    ));

    // Corpo do cachorro (mais retangular)
    pieces.add(PuzzlePiece(
      id: 4,
      name: 'Corpo',
      color: AnimalColors.dogColor.withValues(alpha: 0.8),
      points: [
        const Offset(0.35, 0.45),
        const Offset(0.5, 0.45),
        const Offset(0.65, 0.45),
        const Offset(0.7, 0.65),
        const Offset(0.6, 0.85),
        const Offset(0.4, 0.85),
        const Offset(0.3, 0.65),
      ],
    ));

    // Rabo (mais para cima que o do gato)
    pieces.add(PuzzlePiece(
      id: 5,
      name: 'Rabo',
      color: AnimalColors.dogColor,
      points: [
        const Offset(0.6, 0.85),
        const Offset(0.7, 0.65),
        const Offset(0.85, 0.6),
        const Offset(0.9, 0.4),
      ],
    ));

    // Focinho (diferente do gato)
    pieces.add(PuzzlePiece(
      id: 6,
      name: 'Focinho',
      color: AnimalColors.highlight1,
      points: [
        const Offset(0.35, 0.45),
        const Offset(0.5, 0.45),
        const Offset(0.5, 0.55),
        const Offset(0.35, 0.55),
      ],
    ));

    return pieces;
  }
}
