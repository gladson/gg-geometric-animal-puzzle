import 'package:flutter/material.dart';
import 'animal.dart';
import '../game/models/puzzle_piece.dart';

class Cat implements Animal {
  @override
  String get name => 'Gato';

  @override
  int get difficulty => 1; // Nível fácil

  @override
  Color get backgroundColor => AnimalColors.catColor.withValues(alpha: 0.2);

  @override
  List<PuzzlePiece> generatePieces() {
    List<PuzzlePiece> pieces = [];

    // Cabeça do gato (triângulo para cima)
    pieces.add(PuzzlePiece(
      id: 1,
      name: 'Cabeça',
      color: AnimalColors.catColor,
      points: [
        const Offset(0.3, 0.2),
        const Offset(0.5, 0.05),
        const Offset(0.7, 0.2),
        const Offset(0.65, 0.4),
        const Offset(0.35, 0.4),
      ],
    ));

    // Orelha esquerda (triângulo)
    pieces.add(PuzzlePiece(
      id: 2,
      name: 'Orelha Esquerda',
      color: AnimalColors.highlight5,
      points: [
        const Offset(0.35, 0.4),
        const Offset(0.3, 0.2),
        const Offset(0.2, 0.1),
      ],
    ));

    // Orelha direita (triângulo)
    pieces.add(PuzzlePiece(
      id: 3,
      name: 'Orelha Direita',
      color: AnimalColors.highlight5,
      points: [
        const Offset(0.65, 0.4),
        const Offset(0.7, 0.2),
        const Offset(0.8, 0.1),
      ],
    ));

    // Corpo do gato (forma oval aproximada com polígono)
    pieces.add(PuzzlePiece(
      id: 4,
      name: 'Corpo',
      color: AnimalColors.catColor.withValues(alpha: 0.8),
      points: [
        const Offset(0.35, 0.4),
        const Offset(0.65, 0.4),
        const Offset(0.7, 0.6),
        const Offset(0.6, 0.8),
        const Offset(0.4, 0.8),
        const Offset(0.3, 0.6),
      ],
    ));

    // Rabo (curva representada por triângulo)
    pieces.add(PuzzlePiece(
      id: 5,
      name: 'Rabo',
      color: AnimalColors.catColor,
      points: [
        const Offset(0.6, 0.8),
        const Offset(0.7, 0.6),
        const Offset(0.9, 0.7),
      ],
    ));

    return pieces;
  }
}
