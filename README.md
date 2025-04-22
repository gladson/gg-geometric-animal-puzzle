Version: [PT-BR](pt_BR.md)

# Geometric Animal Puzzle

A colorful and interactive puzzle game for young children, built with Flutter and Dart.

![Image](https://github.com/user-attachments/assets/47390cc2-2191-4a39-8c9e-7fe43e41a375)

## About the Game

Geometric Animal Puzzle is an educational game designed for toddlers and young children. Players complete animal puzzles by dragging and dropping geometric shapes to create recognizable animals. The game features:

- Vibrant colors and simple shapes designed to capture children's attention
- Visual feedback when pieces are in the correct position
- Progressive difficulty levels with different animals
- Reward system with stars and coins to keep children engaged

## How to Play

1. **Select an Animal**: Each level presents a different animal to complete
2. **Drag & Drop**: Drag the colorful shapes from the bottom panel to their correct positions on the board
3. **Visual Guidance**: Watch for the highlighted outlines showing where each piece belongs
4. **Complete the Puzzle**: When all pieces are correctly placed, you advance to the next animal

## Technical Details

- Built with Flutter/Dart
- Uses custom drawing with Flutter's Canvas API instead of images
- Implements drag-and-drop mechanics with visual feedback
- Geometric shapes defined programmatically using coordinate systems

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/geometric-animal-puzzle.git

# Navigate to the project directory
cd geometric-animal-puzzle

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure

```
lib/
  ├── main.dart                  # Entry point
  ├── game/
  │   ├── puzzle_game.dart       # Main game class
  │   └── models/
  │       ├── puzzle_piece.dart  # Puzzle piece model
  │       └── app_theme.dart     # App theming
  ├── painters/
  │   ├── board_painter.dart     # Board painter
  │   └── piece_painter.dart     # Piece painter
  └── animals/
      ├── animal.dart            # Base animal class
      ├── cat.dart               # Cat definition
      ├── dog.dart               # Dog definition
      ├── elephant.dart          # Elephant definition
      ├── lion.dart              # Lion definition
      └── rabbit.dart            # Rabbit definition
```

## Adding New Animals

To add a new animal to the game:

1. Create a new class that implements the `Animal` interface
2. Define the geometric pieces that make up the animal
3. Add the animal to the list in `puzzle_game.dart`

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

Developed with ❤️ for children's education and fun.
