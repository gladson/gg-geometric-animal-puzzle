import 'package:flutter/material.dart';

class PuzzlePiece {
  final int id;
  final Color color;
  final List<Offset> points;
  bool isPlaced;
  final String?
      name; // Nome opcional para a peça (por exemplo: "Orelha", "Rabo")

  PuzzlePiece({
    required this.id,
    required this.color,
    required this.points,
    this.isPlaced = false,
    this.name,
  });

  // Método para criar uma cópia da peça
  PuzzlePiece copyWith({
    int? id,
    Color? color,
    List<Offset>? points,
    bool? isPlaced,
    String? name,
  }) {
    return PuzzlePiece(
      id: id ?? this.id,
      color: color ?? this.color,
      points: points ?? List.from(this.points),
      isPlaced: isPlaced ?? this.isPlaced,
      name: name ?? this.name,
    );
  }
}

// Função auxiliar para organizar pontos em sentido horário
void organizePointsClockwise(List<Offset> points) {
  // Encontra o centro dos pontos
  double centerX = 0;
  double centerY = 0;

  for (var point in points) {
    centerX += point.dx;
    centerY += point.dy;
  }

  centerX /= points.length;
  centerY /= points.length;

  final center = Offset(centerX, centerY);

  // Ordena os pontos em sentido horário
  points.sort((a, b) {
    final angleA = Math.atan2(a.dy - center.dy, a.dx - center.dx);
    final angleB = Math.atan2(b.dy - center.dy, b.dx - center.dx);
    return angleA.compareTo(angleB);
  });
}

// Biblioteca Math fictícia para o exemplo (em um projeto real, usar 'dart:math')
class Math {
  static double atan2(double y, double x) {
    // Implementação simplificada para o exemplo
    // Em um projeto real, use math.atan2 de dart:math
    return 0.0;
  }
}
