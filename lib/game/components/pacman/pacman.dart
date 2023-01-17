import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:pacman/game/components/pacman/pacman_mouth.dart';
import 'package:flutter/material.dart';

enum PacmanDirection { up, down, right, left, quite }

class Pacman extends CircleComponent with TapCallbacks, CollisionCallbacks {
  static Paint yellow = BasicPalette.yellow.paint();
  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();
  static const pxs = 2.0;
  static const Map<PacmanDirection, double> directions = {
    PacmanDirection.up: 1.5708,
    PacmanDirection.down: 4.71239,
    PacmanDirection.right: 3.14159,
    PacmanDirection.left: 0
  };

  late PacmanDirection _pacmanDirection;
  late PolygonComponent mouth;

  Pacman() : super(paint: yellow, angle: 3.14, anchor: Anchor.center) {
    changeDirection(PacmanDirection.left);
  }

  @override
  void update(double dt) {
    super.update(dt);
    caminar();
  }

  @override
  Future<void> onLoad() async {
    init();
    super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    event.handled = true;
  }

  init() {
    mouth = PacmanMouth(pacmanRadius: radius);
    add(mouth);
    add(CircleHitbox(position: Vector2(0, size.y/2), radius: radius/4, isSolid: true));
  }

  changeDirection(PacmanDirection direction) {
    if (direction != PacmanDirection.quite) {
      angle = directions[direction]!;
    }
    _pacmanDirection = direction;
  }

  caminar() {
    switch (_pacmanDirection) {
      case PacmanDirection.up:
        position.y -= pxs;
        break;
      case PacmanDirection.down:
        position.y += pxs;
        break;
      case PacmanDirection.right:
        position.x += pxs;
        break;
      case PacmanDirection.left:
        position.x -= pxs;
        break;
      case PacmanDirection.quite:
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    changeDirection(PacmanDirection.quite);

    super.onCollision(intersectionPoints, other);
  }
}
