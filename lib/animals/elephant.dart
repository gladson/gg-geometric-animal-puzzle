import 'package:flutter/material.dart';
import 'animal.dart';
import '../game/models/puzzle_piece.dart';

class Elephant implements Animal {
  @override
  String get name => 'Elefante';

  @override
  int get difficulty => 3; // Nível mais difícil

  @override
  Color get backgroundColor =>
      AnimalColors.elephantColor.withValues(alpha: 0.2);

  @override
  List<PuzzlePiece> generatePieces() {
    List<PuzzlePiece> pieces = [];

    // VERSÃO REDESENHADA COM MENOS PEÇAS MAS MAIORES E MAIS DISTINTAS

    // Cabeça do elefante com orelhas (uma única peça grande)
    pieces.add(PuzzlePiece(
      id: 1,
      name: 'Cabeça',
      color: AnimalColors.elephantColor,
      points: [
        const Offset(0.25, 0.05), // Topo esquerdo
        const Offset(0.75, 0.05), // Topo direito
        const Offset(0.9, 0.2), // Orelha direita
        const Offset(0.8, 0.3),
        const Offset(0.7, 0.4),
        const Offset(0.3, 0.4),
        const Offset(0.2, 0.3),
        const Offset(0.1, 0.2), // Orelha esquerda
      ],
    ));

    // Corpo do elefante
    pieces.add(PuzzlePiece(
      id: 2,
      name: 'Corpo',
      color: AnimalColors.elephantColor.withValues(alpha: 0.9),
      points: [
        const Offset(0.3, 0.4), // Conecta com a cabeça
        const Offset(0.7, 0.4), // Conecta com a cabeça
        const Offset(0.85, 0.6),
        const Offset(0.8, 0.7),
        const Offset(0.2, 0.7),
        const Offset(0.15, 0.6),
      ],
    ));

    // Tromba (característica única do elefante)
    pieces.add(PuzzlePiece(
      id: 3,
      name: 'Tromba',
      color: AnimalColors.elephantColor,
      points: [
        const Offset(0.45, 0.4), // Conecta com a cabeça
        const Offset(0.55, 0.4), // Conecta com a cabeça
        const Offset(0.6, 0.65),
        const Offset(0.5, 0.7),
        const Offset(0.4, 0.65),
      ],
    ));

    // PERNAS MUITO MAIORES - OCUPANDO METADE DA ALTURA DA TELA

    // Perna esquerda - EXTREMAMENTE GRANDE
    pieces.add(PuzzlePiece(
      id: 4,
      name: 'Perna Esquerda',
      color: Colors.deepPurple.shade300, // Cor distinta
      points: [
        const Offset(0.2, 0.7), // Conecta com o corpo
        const Offset(0.4, 0.7), // Conecta com o corpo
        const Offset(0.4, 1.0), // Vai até o fundo da tela
        const Offset(0.2, 1.0), // Vai até o fundo da tela
      ],
    ));

    // Perna direita - EXTREMAMENTE GRANDE
    pieces.add(PuzzlePiece(
      id: 5,
      name: 'Perna Direita',
      color: Colors.deepPurple.shade300, // Cor distinta
      points: [
        const Offset(0.6, 0.7), // Conecta com o corpo
        const Offset(0.8, 0.7), // Conecta com o corpo
        const Offset(0.8, 1.0), // Vai até o fundo da tela
        const Offset(0.6, 1.0), // Vai até o fundo da tela
      ],
    ));

    // Rabo (maior e mais visível)
    pieces.add(PuzzlePiece(
      id: 6,
      name: 'Rabo',
      color: AnimalColors.elephantColor,
      points: [
        const Offset(0.15, 0.6), // Conecta com o corpo
        const Offset(0.05, 0.7),
        const Offset(0.02, 0.8),
        const Offset(0.1, 0.75),
      ],
    ));

    return pieces;
  }
}
