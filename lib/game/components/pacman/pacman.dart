import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:pacman/game/components/pacman/pacman_mouth.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/pacman_game.dart';

enum PacmanDirection { up, down, right, left }

class Pacman extends CircleComponent with TapCallbacks {
  static Paint yellow = BasicPalette.yellow.paint();
  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();
  static const playerRadius = 10.0;
  static const Map<PacmanDirection, double> directions = {
    PacmanDirection.up: 1.5708,
    PacmanDirection.down: 4.71239,
    PacmanDirection.right: 3.14159,
    PacmanDirection.left: 0
  };

  late PacmanDirection _pacmanDirection;
  late PolygonComponent mouth;

  Pacman({required Vector2 position})
      : super(
          paint: yellow,
          position: position,
          anchor: Anchor.center,
          angle: 3.14,
          radius: playerRadius,
        ) {
          changeDirection(PacmanDirection.left);
        }

  @override
  void update(double dt) { 
    super.update(dt);
    caminar();
  }

  @override
  Future<void> onLoad() async {
    mouth = PacmanMouth();
    debugPrint('statement');
    
    add(mouth);
    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    event.handled = true;
  }

  changeDirection(PacmanDirection direction) {
    angle = directions[direction]!;
    _pacmanDirection = direction;
  }

  caminar() {
    switch(_pacmanDirection) {
      case PacmanDirection.up:
        position.y--;
        break;
      case PacmanDirection.down:
        position.y++;
        break;
      case PacmanDirection.right:
        position.x++;
        break;
      case PacmanDirection.left:
        position.x--;
        break;
    }
  }
}
