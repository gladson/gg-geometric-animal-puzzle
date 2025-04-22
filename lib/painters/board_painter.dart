import 'package:flutter/material.dart';
import '../game/models/puzzle_piece.dart';

// Painter para o tabuleiro
class BoardPainter extends CustomPainter {
  final List<PuzzlePiece> pieces;
  final int? hoveredPieceId; // ID da peça que está sendo hover
  final double pulseValue; // Valor da animação de pulso

  BoardPainter(this.pieces, {this.hoveredPieceId, this.pulseValue = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    // Desenha primeiro todas as peças que não estão em hover
    for (PuzzlePiece piece in pieces) {
      if (piece.isPlaced) {
        _drawPiece(canvas, size, piece);
      } else if (hoveredPieceId != piece.id) {
        // Desenha o contorno da posição que a peça deve ocupar
        _drawPieceOutline(canvas, size, piece, isHovered: false);
      }
    }

    // Desenha por último a peça que está em hover (para ficar por cima)
    if (hoveredPieceId != null) {
      PuzzlePiece? hoveredPiece;
      for (var piece in pieces) {
        if (piece.id == hoveredPieceId && !piece.isPlaced) {
          hoveredPiece = piece;
          break;
        }
      }

      if (hoveredPiece != null) {
        _drawPieceOutline(canvas, size, hoveredPiece, isHovered: true);
      }
    }
  }

  void _drawPiece(Canvas canvas, Size size, PuzzlePiece piece) {
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

      // Desenha contorno para peças colocadas
      final Paint borderPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawPath(path, borderPaint);

      // Adiciona o nome da peça se for pequena (como pernas)
      // Verifica se a peça é pequena (área menor que 10% da tela)
      bool isPieceSmall = _isPieceSmall(piece, size);

      if (isPieceSmall && piece.name != null) {
        // Calcula o centro da peça para posicionar o texto
        double centerX = 0;
        double centerY = 0;
        for (var point in piece.points) {
          centerX += point.dx;
          centerY += point.dy;
        }
        centerX = (centerX / piece.points.length) * size.width;
        centerY = (centerY / piece.points.length) * size.height;

        // Configuração da pintura do texto
        final TextSpan textSpan = TextSpan(
          text: piece.name!
              .split(' ')
              .last, // Apenas a última parte do nome (ex: "Frontal" de "Perna Esq. Frontal")
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 2,
                color: Colors.black.withValues(alpha: 0.8),
              ),
            ],
          ),
        );

        final TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            centerX - textPainter.width / 2,
            centerY - textPainter.height / 2,
          ),
        );
      }
    }
  }

  // Verifica se uma peça é pequena (útil para determinar quando adicionar texto ou destaque especial)
  bool _isPieceSmall(PuzzlePiece piece, Size size) {
    if (piece.points.length < 3) return true; // Não é um polígono completo

    // Calcula a área aproximada da peça
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = 0;
    double maxY = 0;

    for (var point in piece.points) {
      if (point.dx < minX) minX = point.dx;
      if (point.dy < minY) minY = point.dy;
      if (point.dx > maxX) maxX = point.dx;
      if (point.dy > maxY) maxY = point.dy;
    }

    double width = (maxX - minX) * size.width;
    double height = (maxY - minY) * size.height;
    double area = width * height;

    // Área total da tela
    double screenArea = size.width * size.height;

    // Considera pequena se for menos de 5% da área da tela
    return area < (screenArea * 0.05);
  }

  void _drawPieceOutline(Canvas canvas, Size size, PuzzlePiece piece,
      {bool isHovered = false}) {
    // --- EFEITO VISUAL MUITO MAIS EVIDENTE ---

    // Determina se é uma peça pequena (como pernas de animais)
    bool isPieceSmall = _isPieceSmall(piece, size);

    // Cria o caminho com os pontos da peça
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

      // Determina as cores e estilos com base no estado de hover
      if (isHovered) {
        // ==== PREENCHIMENTO QUANDO EM HOVER ====
        final Paint fillPaint = Paint()
          ..color =
              piece.color.withValues(alpha: 0.7) // Cor mais opaca quando hover
          ..style = PaintingStyle.fill;
        canvas.drawPath(path, fillPaint);

        // ==== BORDA QUANDO EM HOVER ====
        // Contorno pulsante mais grosso e colorido
        final Paint borderPaint = Paint()
          ..color = Colors.yellow // Amarelo brilhante - MUITO visível
          ..style = PaintingStyle.stroke
          ..strokeWidth = isPieceSmall
              ? 5.0
              : 4.0 + (pulseValue * 2.0); // Mais grosso para peças pequenas
        canvas.drawPath(path, borderPaint);

        // Segundo contorno interno para efeito de destaque duplo
        final Paint innerBorderPaint = Paint()
          ..color = Colors.white // Contorno branco interno
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

        canvas.drawPath(path, innerBorderPaint);

        // Adiciona um destaque especial para peças pequenas
        if (isPieceSmall) {
          // Desenha um círculo de destaque ao redor do centro da peça
          double centerX = 0;
          double centerY = 0;
          for (var point in piece.points) {
            centerX += point.dx;
            centerY += point.dy;
          }
          centerX = (centerX / piece.points.length) * size.width;
          centerY = (centerY / piece.points.length) * size.height;

          // Círculo de destaque pulsante
          final Paint glowPaint = Paint()
            ..color = Colors.yellow.withValues(alpha: 0.3)
            ..style = PaintingStyle.fill;

          double glowRadius = 25.0 + (pulseValue * 10.0); // Raio pulsante

          canvas.drawCircle(
            Offset(centerX, centerY),
            glowRadius,
            glowPaint,
          );

          // Adiciona uma seta apontando para a peça
          final Paint arrowPaint = Paint()
            ..color = Colors.yellow
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.0;

          // Desenha uma seta simples
          final Path arrowPath = Path();
          arrowPath.moveTo(centerX, centerY - glowRadius - 20);
          arrowPath.lineTo(centerX, centerY - glowRadius - 5);
          canvas.drawPath(arrowPath, arrowPaint);

          // Ponta da seta
          final Path arrowHeadPath = Path();
          arrowHeadPath.moveTo(centerX, centerY - glowRadius);
          arrowHeadPath.lineTo(centerX - 8, centerY - glowRadius - 10);
          arrowHeadPath.moveTo(centerX, centerY - glowRadius);
          arrowHeadPath.lineTo(centerX + 8, centerY - glowRadius - 10);
          canvas.drawPath(arrowHeadPath, arrowPaint);

          // Adiciona texto "AQUI!" para peças muito pequenas
          final TextSpan textSpan = TextSpan(
            text: "AQUI!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ],
            ),
          );

          final TextPainter textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          );

          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(
              centerX - textPainter.width / 2,
              centerY - glowRadius - 40 - textPainter.height,
            ),
          );
        }
      } else {
        // ==== PREENCHIMENTO QUANDO NÃO EM HOVER ====
        final Paint fillPaint = Paint()
          ..color = Colors.grey.withValues(alpha: 0.2)
          ..style = PaintingStyle.fill;
        canvas.drawPath(path, fillPaint);

        // ==== BORDA QUANDO NÃO EM HOVER ====
        final Paint borderPaint = Paint()
          ..color = Colors.grey.withValues(alpha: 0.7) // Mais visível que antes
          ..style = PaintingStyle.stroke
          ..strokeWidth =
              isPieceSmall ? 3.0 : 2.0; // Mais grosso para peças pequenas
        canvas.drawPath(path, borderPaint);

        // Para peças pequenas, adiciona um contorno pontilhado mais visível
        if (isPieceSmall) {
          // Calcula o centro da peça
          double centerX = 0;
          double centerY = 0;
          for (var point in piece.points) {
            centerX += point.dx;
            centerY += point.dy;
          }
          centerX = (centerX / piece.points.length) * size.width;
          centerY = (centerY / piece.points.length) * size.height;

          // Adiciona o nome da peça para facilitar identificação
          if (piece.name != null) {
            final TextSpan textSpan = TextSpan(
              text: piece.name!.split(' ').last, // Última parte do nome
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.7),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            );

            final TextPainter textPainter = TextPainter(
              text: textSpan,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            );

            textPainter.layout();
            textPainter.paint(
              canvas,
              Offset(
                centerX - textPainter.width / 2,
                centerY - textPainter.height / 2,
              ),
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return oldDelegate.hoveredPieceId != hoveredPieceId ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.pieces != pieces;
  }
}
