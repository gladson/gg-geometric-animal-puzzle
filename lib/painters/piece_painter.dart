import 'package:flutter/material.dart';
import '../game/models/puzzle_piece.dart';

// Painter para as peças individuais
class PiecePainter extends CustomPainter {
  final PuzzlePiece piece;

  PiecePainter(this.piece);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = piece.color
      ..style = PaintingStyle.fill;

    final Path path = Path();

    if (piece.points.isNotEmpty) {
      path.moveTo(
        piece.points[0].dx * size.width,
        piece.points[0].dy * size.height,
      );

      for (int i = 1; i < piece.points.length; i++) {
        path.lineTo(
          piece.points[i].dx * size.width,
          piece.points[i].dy * size.height,
        );
      }

      path.close();
      canvas.drawPath(path, paint);

      // Desenha contorno
      final Paint borderPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawPath(path, borderPaint);

      // Opcional: Adiciona um efeito de gradiente ou sombra interna
      // para dar mais dimensão às peças
      final Paint highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill;

      // Cria um caminho menor para simular uma área de destaque
      final Path highlightPath = Path();
      final List<Offset> scaledPoints = [];

      // Encontra o centro da forma
      double centerX = 0;
      double centerY = 0;
      for (var point in piece.points) {
        centerX += point.dx;
        centerY += point.dy;
      }
      centerX /= piece.points.length;
      centerY /= piece.points.length;

      // Escala os pontos em 10% em direção ao centro
      for (var point in piece.points) {
        double scaledX = point.dx + (centerX - point.dx) * 0.1;
        double scaledY = point.dy + (centerY - point.dy) * 0.1;
        scaledPoints.add(Offset(scaledX * size.width, scaledY * size.height));
      }

      // Desenha o destaque
      if (scaledPoints.isNotEmpty) {
        highlightPath.moveTo(scaledPoints[0].dx, scaledPoints[0].dy);

        for (int i = 1; i < scaledPoints.length; i++) {
          highlightPath.lineTo(scaledPoints[i].dx, scaledPoints[i].dy);
        }

        highlightPath.close();
        canvas.drawPath(highlightPath, highlightPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
