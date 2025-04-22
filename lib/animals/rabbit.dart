import 'package:flutter/material.dart';
import 'animal.dart';
import '../game/models/puzzle_piece.dart';

class Rabbit implements Animal {
  @override
  String get name => 'Coelho';

  @override
  int get difficulty => 2; // Nível médio

  @override
  Color get backgroundColor => AnimalColors.rabbitColor.withValues(alpha: 0.2);

  @override
  List<PuzzlePiece> generatePieces() {
    List<PuzzlePiece> pieces = [];

    // Cabeça do coelho (oval)
    pieces.add(PuzzlePiece(
      id: 1,
      name: 'Cabeça',
      color: AnimalColors.rabbitColor,
      points: [
        const Offset(0.3, 0.3),
        const Offset(0.5, 0.2),
        const Offset(0.7, 0.3),
        const Offset(0.75, 0.5),
        const Offset(0.7, 0.7),
        const Offset(0.5, 0.8),
        const Offset(0.3, 0.7),
        const Offset(0.25, 0.5),
      ],
    ));

    // Orelha esquerda (característica marcante de coelhos)
    pieces.add(PuzzlePiece(
      id: 2,
      name: 'Orelha Esquerda',
      color: AnimalColors.rabbitColor.withValues(alpha: 0.9),
      points: [
        const Offset(0.4, 0.25),
        const Offset(0.35, 0.05),
        const Offset(0.3, 0.0),
        const Offset(0.25, 0.05),
        const Offset(0.3, 0.3),
      ],
    ));

    // Orelha direita
    pieces.add(PuzzlePiece(
      id: 3,
      name: 'Orelha Direita',
      color: AnimalColors.rabbitColor.withValues(alpha: 0.9),
      points: [
        const Offset(0.6, 0.25),
        const Offset(0.65, 0.05),
        const Offset(0.7, 0.0),
        const Offset(0.75, 0.05),
        const Offset(0.7, 0.3),
      ],
    ));

    // Parte interna das orelhas (rosa)
    pieces.add(PuzzlePiece(
      id: 4,
      name: 'Interior das Orelhas',
      color: Colors.pink.withValues(alpha: 0.5),
      points: [
        const Offset(0.35, 0.1),
        const Offset(0.33, 0.05),
        const Offset(0.3, 0.05),
        const Offset(0.32, 0.15),
        const Offset(0.65, 0.1),
        const Offset(0.67, 0.05),
        const Offset(0.7, 0.05),
        const Offset(0.68, 0.15),
      ],
    ));

    // Corpo
    pieces.add(PuzzlePiece(
      id: 5,
      name: 'Corpo',
      color: AnimalColors.highlight4,
      points: [
        const Offset(0.4, 0.7),
        const Offset(0.6, 0.7),
        const Offset(0.7, 0.8),
        const Offset(0.65, 0.95),
        const Offset(0.35, 0.95),
        const Offset(0.3, 0.8),
      ],
    ));

    // Focinho
    pieces.add(PuzzlePiece(
      id: 6,
      name: 'Focinho',
      color: Colors.pink.withValues(alpha: 0.7),
      points: [
        const Offset(0.45, 0.5),
        const Offset(0.55, 0.5),
        const Offset(0.55, 0.6),
        const Offset(0.45, 0.6),
      ],
    ));

    // Rabinho (um pequeno círculo aproximado por um polígono)
    pieces.add(PuzzlePiece(
      id: 7,
      name: 'Rabinho',
      color: Colors.white,
      points: [
        const Offset(0.35, 0.95),
        const Offset(0.4, 0.93),
        const Offset(0.42, 0.95),
        const Offset(0.4, 0.97),
      ],
    ));

    return pieces;
  }
}
