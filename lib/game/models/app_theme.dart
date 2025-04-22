import 'package:flutter/material.dart';

class AppTheme {
  // Cores vibrantes para atrair crianças pequenas
  final Color backgroundColor = const Color(0xFF3E2723); // Marrom escuro
  final Color headerColor = const Color(0xFF4CAF50); // Verde vibrante
  final Color boardBackgroundColor = const Color(0xFFE0E0E0); // Cinza claro
  final Color piecesAreaColor = const Color(0xFF5C6BC0); // Azul-roxo
  final Color textColor = Colors.white;
  final Color borderColor = const Color(0xFFFFD54F); // Amarelo âmbar
  final Color starColor = const Color(0xFFFFD700); // Dourado
  final Color coinColor = const Color(0xFFFFD700); // Dourado

  // Cores de realce
  final Color successColor = const Color(0xFF4CAF50); // Verde
  final Color errorColor = const Color(0xFFF44336); // Vermelho

  // Estilos de texto
  TextStyle get titleStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  TextStyle get headingStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  TextStyle get bodyStyle => const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );

  // Estilos de decoração
  BoxDecoration get buttonDecoration => BoxDecoration(
        color: const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      );

  BoxDecoration get cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
}
