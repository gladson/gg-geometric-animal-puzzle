import 'package:flutter/material.dart';
import 'animal.dart';
import '../game/models/puzzle_piece.dart';

class Lion implements Animal {
  @override
  String get name => 'Leão';

  @override
  int get difficulty => 3; // Nível difícil

  @override
  Color get backgroundColor => AnimalColors.lionColor.withValues(alpha: 0.2);

  @override
  List<PuzzlePiece> generatePieces() {
    List<PuzzlePiece> pieces = [];

    // Juba principal (característica marcante do leão)
    pieces.add(PuzzlePiece(
      id: 1,
      name: 'Juba',
      color: AnimalColors.lionColor,
      points: [
        const Offset(0.2, 0.1),
        const Offset(0.35, 0.05),
        const Offset(0.5, 0.03),
        const Offset(0.65, 0.05),
        const Offset(0.8, 0.1),
        const Offset(0.9, 0.2),
        const Offset(0.85, 0.3),
        const Offset(0.75, 0.4),
        const Offset(0.25, 0.4),
        const Offset(0.15, 0.3),
        const Offset(0.1, 0.2),
      ],
    ));

    // Cabeça (dentro da juba)
    pieces.add(PuzzlePiece(
      id: 2,
      name: 'Cabeça',
      color: AnimalColors.highlight3.withValues(alpha: 0.9),
      points: [
        const Offset(0.35, 0.2),
        const Offset(0.5, 0.15),
        const Offset(0.65, 0.2),
        const Offset(0.7, 0.3),
        const Offset(0.5, 0.4),
        const Offset(0.3, 0.3),
      ],
    ));

    // Focinho
    pieces.add(PuzzlePiece(
      id: 3,
      name: 'Focinho',
      color: AnimalColors.highlight1,
      points: [
        const Offset(0.45, 0.35),
        const Offset(0.55, 0.35),
        const Offset(0.55, 0.45),
        const Offset(0.45, 0.45),
      ],
    ));

    // Corpo
    pieces.add(PuzzlePiece(
      id: 4,
      name: 'Corpo',
      color: AnimalColors.lionColor.withValues(alpha: 0.8),
      points: [
        const Offset(0.35, 0.4),
        const Offset(0.65, 0.4),
        const Offset(0.8, 0.6),
        const Offset(0.7, 0.85),
        const Offset(0.3, 0.85),
        const Offset(0.2, 0.6),
      ],
    ));

    // Perna dianteira esquerda
    pieces.add(PuzzlePiece(
      id: 5,
      name: 'Pata Frontal Esquerda',
      color: AnimalColors.highlight3,
      points: [
        const Offset(0.3, 0.85),
        const Offset(0.35, 0.85),
        const Offset(0.35, 1.0),
        const Offset(0.25, 1.0),
        const Offset(0.25, 0.9),
      ],
    ));

    // Perna dianteira direita
    pieces.add(PuzzlePiece(
      id: 6,
      name: 'Pata Frontal Direita',
      color: AnimalColors.highlight3,
      points: [
        const Offset(0.65, 0.85),
        const Offset(0.7, 0.85),
        const Offset(0.75, 0.9),
        const Offset(0.75, 1.0),
        const Offset(0.65, 1.0),
      ],
    ));

    // Rabo
    pieces.add(PuzzlePiece(
      id: 7,
      name: 'Rabo',
      color: AnimalColors.lionColor,
      points: [
        const Offset(0.2, 0.6),
        const Offset(0.1, 0.7),
        const Offset(0.05, 0.85),
        const Offset(0.15, 0.9),
      ],
    ));

    return pieces;
  }
}
