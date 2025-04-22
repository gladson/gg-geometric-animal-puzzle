import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models/puzzle_piece.dart';
import 'models/app_theme.dart';
import '../animals/animal.dart';
import '../animals/cat.dart';
import '../animals/dog.dart';
import '../animals/elephant.dart';
import '../animals/lion.dart';
import '../animals/rabbit.dart';
import '../painters/board_painter.dart';
import '../painters/piece_painter.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({super.key});

  @override
  PuzzleGameState createState() => PuzzleGameState();
}

class PuzzleGameState extends State<PuzzleGame> with TickerProviderStateMixin {
  int level = 1;
  int stars = 0;
  int coins = 50;
  List<PuzzlePiece> boardPieces = [];
  List<PuzzlePiece> availablePieces = [];
  int placedPiecesCount = 0;
  late Animal currentAnimal;

  // Estado para controlar o "hover" das peças
  int? hoveredPieceId;
  Offset? hoverPosition;
  Size? boardSize;

  // Lista de animais disponíveis
  final List<Animal> animals = [
    Cat(),
    Dog(),
    Elephant(),
    Lion(),
    Rabbit(),
  ];

  // Controladores de animação
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _isShowingErrorAnimation = false;

  // Controlador para animação de pulso para o efeito de hover
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores de animação
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: -10.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _isShowingErrorAnimation = false;
        }
      });

    // Inicializa a animação de pulso mais rápida para melhor feedback
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 600), // Mais rápido
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_pulseController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _pulseController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _pulseController.forward();
        }
      });

    // Inicializa o primeiro nível
    _loadLevel(level);

    // Inicia a animação de pulso
    _pulseController.forward();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _loadLevel(int levelNumber) {
    // Limpa o estado anterior
    boardPieces.clear();
    availablePieces.clear();
    placedPiecesCount = 0;
    hoveredPieceId = null;
    hoverPosition = null;

    // Escolhe o animal com base no nível
    int animalIndex = (levelNumber - 1) % animals.length;
    currentAnimal = animals[animalIndex];

    // Gera as peças do animal
    boardPieces = currentAnimal.generatePieces();

    // Cria cópias das peças para a área de peças disponíveis
    for (PuzzlePiece piece in boardPieces) {
      availablePieces.add(piece.copyWith(isPlaced: false));
    }

    // Embaralha as peças disponíveis
    availablePieces.shuffle();
  }

  // Método auxiliar para mostrar feedbacks visuais e sonoros
  void _showCorrectPlacementFeedback() {
    // Aqui poderíamos adicionar um som de sucesso e/ou uma animação
    // Exemplo de código para reproduzir som (exigiria pacote de som):
    // audioPlayer.play('assets/sounds/correct.mp3');
  }

  void _handlePiecePlacement(PuzzlePiece piece, {bool fromDrop = false}) {
    // Apenas processa se for chamado a partir de um evento de drop
    if (!fromDrop) return;

    setState(() {
      // Limpa o estado de hover
      hoveredPieceId = null;

      // Encontra e marca a peça correspondente no board
      for (int i = 0; i < boardPieces.length; i++) {
        if (boardPieces[i].id == piece.id && !boardPieces[i].isPlaced) {
          boardPieces[i].isPlaced = true;
          placedPiecesCount++;
          break;
        }
      }

      // Remove a peça da lista de disponíveis
      availablePieces.removeWhere((p) => p.id == piece.id);

      // Mostra feedback de posicionamento correto
      _showCorrectPlacementFeedback();

      // Verifica conclusão do nível
      if (placedPiecesCount == boardPieces.length) {
        _completeLevel();
      }
    });
  }

  // Animação de erro quando uma peça é colocada em um local errado
  void _showErrorAnimation() {
    setState(() {
      _isShowingErrorAnimation = true;
      hoveredPieceId = null; // Limpa o estado de hover
    });
    _shakeController.forward(from: 0.0);
  }

  // Verifica se uma peça está próxima de sua posição correta e atualiza o estado de hover
  void _updateHoverState(PuzzlePiece piece, Offset position) {
    if (boardSize == null) return;

    // Encontrar a peça correspondente no tabuleiro
    PuzzlePiece? targetPiece;
    for (var p in boardPieces) {
      if (p.id == piece.id && !p.isPlaced) {
        targetPiece = p;
        break;
      }
    }

    if (targetPiece == null) return;

    // Calcular o centro da peça de destino
    double centerX = 0;
    double centerY = 0;
    for (var point in targetPiece.points) {
      centerX += point.dx;
      centerY += point.dy;
    }
    centerX /= targetPiece.points.length;
    centerY /= targetPiece.points.length;

    // Converter para coordenadas de pixels
    centerX *= boardSize!.width;
    centerY *= boardSize!.height;

    // Definir uma margem de tolerância MUITO MAIOR para o posicionamento hover
    // Isso garante que o hover seja mais fácil de ativar
    final double tolerance =
        boardSize!.width * 0.35; // 35% do tamanho do tabuleiro

    // Calcular a distância entre o ponto atual e o centro da peça de destino
    final double distance = math.sqrt(math.pow(position.dx - centerX, 2) +
        math.pow(position.dy - centerY, 2));

    if (kDebugMode) {
      print(
          "Peça ID: ${piece.id}, Distância: $distance, Tolerância: $tolerance");
      print("Hover: ${distance < tolerance ? 'SIM' : 'NÃO'}");
    }

    // Apenas atualiza o estado se houver mudança
    if (distance < tolerance) {
      if (hoveredPieceId != piece.id) {
        setState(() {
          hoveredPieceId = piece.id;
          hoverPosition = position;
        });
      }
    } else {
      if (hoveredPieceId == piece.id) {
        setState(() {
          hoveredPieceId = null;
          hoverPosition = null;
        });
      }
    }
  }

  // Verifica se uma peça está sendo colocada na posição aproximadamente correta
  bool _isPieceNearCorrectPosition(
      PuzzlePiece piece, Offset dropPosition, Size size) {
    // Atualiza o tamanho do tabuleiro para uso em outros métodos
    boardSize = size;

    // Encontrar a peça correspondente no tabuleiro
    PuzzlePiece? targetPiece;
    for (var p in boardPieces) {
      if (p.id == piece.id && !p.isPlaced) {
        targetPiece = p;
        break;
      }
    }

    if (targetPiece == null) return false;

    // Calcular o centro da peça de destino
    double centerX = 0;
    double centerY = 0;
    for (var point in targetPiece.points) {
      centerX += point.dx;
      centerY += point.dy;
    }
    centerX /= targetPiece.points.length;
    centerY /= targetPiece.points.length;

    // Converter para coordenadas de pixels
    centerX *= size.width;
    centerY *= size.height;

    // Definir uma margem de tolerância mais generosa para o posicionamento
    final double tolerance = size.width * 0.25; // 25% do tamanho do tabuleiro

    // Calcular a distância entre o ponto de soltura e o centro da peça de destino
    final double distance = math.sqrt(math.pow(dropPosition.dx - centerX, 2) +
        math.pow(dropPosition.dy - centerY, 2));

    if (kDebugMode) {
      print(
          "DROP - Peça ID: ${piece.id}, Distância: $distance, Tolerância: $tolerance");
      print("Aceito: ${distance < tolerance ? 'SIM' : 'NÃO'}");
    }

    // Retornar verdadeiro se a distância for menor que a tolerância
    return distance < tolerance;
  }

  void _completeLevel() {
    // Adiciona recompensas
    setState(() {
      stars++;
      coins += 10;
    });

    // Mostra diálogo de conclusão
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('${currentAnimal.name} Completo!'),
            content: Text('Você completou o nível $level!\nGanhou +10 moedas'),
            actions: [
              TextButton(
                child: const Text('Próximo Animal'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    level++;
                    _loadLevel(level);
                  });
                },
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();

    return Scaffold(
      backgroundColor: currentAnimal.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header com pontuação e nível
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: theme.headerColor,
              child: Row(
                children: [
                  // Estrelas
                  Row(
                    children: [
                      Icon(Icons.star, color: theme.starColor, size: 24),
                      const SizedBox(width: 4),
                      Text(
                        '$stars',
                        style: TextStyle(
                          color: theme.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Nome do animal
                  Text(
                    currentAnimal.name,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  // Moedas
                  Row(
                    children: [
                      Icon(Icons.monetization_on,
                          color: theme.coinColor, size: 24),
                      const SizedBox(width: 4),
                      Text(
                        '$coins',
                        style: TextStyle(
                          color: theme.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Área principal do jogo - quebra-cabeça e peças
            Expanded(
              child: Column(
                children: [
                  // Área do quebra-cabeça (tabuleiro)
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.boardBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.borderColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            // Área principal do tabuleiro com DragTarget
                            DragTarget<PuzzlePiece>(
                              onWillAcceptWithDetails: (details) {
                                final PuzzlePiece piece = details.data;

                                // Verifica se a peça já foi colocada
                                bool canAccept = !boardPieces
                                    .any((p) => p.id == piece.id && p.isPlaced);

                                if (canAccept) {
                                  final RenderBox renderBox =
                                      context.findRenderObject() as RenderBox;

                                  // Converte a posição global para local (relativa ao tabuleiro)
                                  final Offset localPosition =
                                      renderBox.globalToLocal(details.offset);

                                  // Atualiza o estado de hover de forma mais confiável
                                  _updateHoverState(piece, localPosition);
                                }

                                return canAccept;
                              },
                              onAcceptWithDetails: (details) {
                                final PuzzlePiece piece = details.data;
                                final RenderBox renderBox =
                                    context.findRenderObject() as RenderBox;
                                final Size boardSize = renderBox.size;

                                // Converte a posição global do drop para local (relativa ao tabuleiro)
                                final Offset localPosition =
                                    renderBox.globalToLocal(details.offset);

                                // Verifica se a peça está próxima da posição correta
                                if (_isPieceNearCorrectPosition(
                                    piece, localPosition, boardSize)) {
                                  // Posicionamento correto!
                                  _handlePiecePlacement(piece, fromDrop: true);
                                } else {
                                  // Posicionamento incorreto - mostrar animação de erro
                                  _showErrorAnimation();
                                }
                              },
                              onLeave: (data) {
                                setState(() {
                                  hoveredPieceId = null;
                                  hoverPosition = null;
                                });
                              },
                              onMove: (details) {
                                // Adiciona atualização adicional durante o movimento para maior responsividade
                                final PuzzlePiece piece = details.data;

                                // Verifica se a peça já foi colocada
                                bool canAccept = !boardPieces
                                    .any((p) => p.id == piece.id && p.isPlaced);

                                if (canAccept) {
                                  final RenderBox renderBox =
                                      context.findRenderObject() as RenderBox;
                                  if (renderBox.hasSize) {
                                    // Converte a posição global para local (relativa ao tabuleiro)
                                    final Offset localPosition =
                                        renderBox.globalToLocal(details.offset);

                                    // Atualiza o estado de hover
                                    _updateHoverState(piece, localPosition);
                                  }
                                }
                              },
                              builder: (context, candidateData, rejectedData) {
                                return AnimatedBuilder(
                                  animation: Listenable.merge(
                                      [_shakeAnimation, _pulseAnimation]),
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: _isShowingErrorAnimation
                                          ? Offset(_shakeAnimation.value, 0)
                                          : const Offset(0, 0),
                                      child: CustomPaint(
                                        painter: BoardPainter(
                                          boardPieces,
                                          hoveredPieceId: hoveredPieceId,
                                          pulseValue: _pulseAnimation.value,
                                        ),
                                        child: Container(), // Placeholder
                                      ),
                                    );
                                  },
                                );
                              },
                            ),

                            // Indicador de hover (opcional)
                            if (hoveredPieceId != null)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Área das peças disponíveis
                  Container(
                    height: 150,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      color: theme.piecesAreaColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.borderColor, width: 3),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(10),
                      children: [
                        for (PuzzlePiece piece in availablePieces)
                          Draggable<PuzzlePiece>(
                            data: piece,
                            // Feedback que é exibido durante o arrasto
                            feedback: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                painter: PiecePainter(piece),
                              ),
                            ),
                            childWhenDragging:
                                const SizedBox(width: 80, height: 80),
                            onDragStarted: () {
                              // Limpa o estado de hover ao começar a arrastar
                              setState(() {
                                hoveredPieceId = null;
                                hoverPosition = null;
                              });
                            },
                            onDragEnd: (details) {
                              setState(() {
                                hoveredPieceId = null;
                                hoverPosition = null;
                              });
                            },
                            onDragUpdate: (details) {
                              // Opcional: adicionar lógica aqui se necessário
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: 80,
                                  height: 80,
                                  child: CustomPaint(
                                    painter: PiecePainter(piece),
                                  ),
                                ),
                                // Opcional: Adicionar rótulo da peça para facilitar
                                if (piece.name != null)
                                  Positioned(
                                    bottom: 5,
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.black.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        piece.name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                // Indicador visual quando a peça está selecionada
                                if (hoveredPieceId == piece.id)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.yellow,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
