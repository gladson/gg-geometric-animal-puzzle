Version: [EN](README.md)

# Quebra-Cabeça Geométrico de Animais

Um jogo de quebra-cabeça colorido e interativo para crianças pequenas, desenvolvido com Flutter e Dart.

![Image](https://github.com/user-attachments/assets/47390cc2-2191-4a39-8c9e-7fe43e41a375)

## Sobre o Jogo

Quebra-Cabeça Geométrico de Animais é um jogo educativo projetado para bebês e crianças pequenas. Os jogadores completam quebra-cabeças de animais arrastando e soltando formas geométricas para criar animais reconhecíveis. O jogo apresenta:

- Cores vibrantes e formas simples projetadas para capturar a atenção das crianças
- Feedback visual quando as peças estão na posição correta
- Níveis progressivos de dificuldade com diferentes animais
- Sistema de recompensa com estrelas e moedas para manter as crianças engajadas

## Como Jogar

1. **Selecione um Animal**: Cada nível apresenta um animal diferente para completar
2. **Arraste e Solte**: Arraste as formas coloridas do painel inferior para suas posições corretas no tabuleiro
3. **Orientação Visual**: Observe os contornos destacados mostrando onde cada peça pertence
4. **Complete o Quebra-Cabeça**: Quando todas as peças estiverem corretamente posicionadas, você avança para o próximo animal

## Detalhes Técnicos

- Desenvolvido com Flutter/Dart
- Usa desenho personalizado com a API Canvas do Flutter em vez de imagens
- Implementa mecânicas de arrastar e soltar com feedback visual
- Formas geométricas definidas programaticamente usando sistemas de coordenadas

## Instalação

```bash
# Clone o repositório
git clone https://github.com/gladson/gg-geometric-animal-puzzle.git

# Navegue até o diretório do projeto
cd gg-geometric-animal-puzzle

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

## Estrutura do Projeto

```
lib/
  ├── main.dart                  # Ponto de entrada
  ├── game/
  │   ├── puzzle_game.dart       # Classe principal do jogo
  │   └── models/
  │       ├── puzzle_piece.dart  # Modelo de peça do quebra-cabeça
  │       └── app_theme.dart     # Tema do aplicativo
  ├── painters/
  │   ├── board_painter.dart     # Pintor do tabuleiro
  │   └── piece_painter.dart     # Pintor de peças
  └── animals/
      ├── animal.dart            # Classe base de animal
      ├── cat.dart               # Definição do gato
      ├── dog.dart               # Definição do cachorro
      ├── elephant.dart          # Definição do elefante
      ├── lion.dart              # Definição do leão
      └── rabbit.dart            # Definição do coelho
```

## Adicionando Novos Animais

Para adicionar um novo animal ao jogo:

1. Crie uma nova classe que implementa a interface `Animal`
2. Defina as peças geométricas que compõem o animal
3. Adicione o animal à lista em `puzzle_game.dart`

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Créditos

Desenvolvido com ❤️ para educação e diversão infantil.
