import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:pacman/game/components/pacman/pacman_mouth.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/components/walls/wall.dart';

enum PacmanDirection { up, down, right, left, quite }

class Pacman extends CircleComponent with TapCallbacks, CollisionCallbacks {

  static Paint yellow = BasicPalette.yellow.paint();
  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();
  static const pxs = 50.0;
  static const Map<PacmanDirection, double> directions = {
    PacmanDirection.up: 1.5708,
    PacmanDirection.down: 4.71239,
    PacmanDirection.right: 3.14159,
    PacmanDirection.left: 0
  };

  PacmanDirection _pacmanDirection = PacmanDirection.quite,
      _pacmanLastDirection = PacmanDirection.quite;
  late PolygonComponent mouth;

  Pacman() : super(paint: yellow, angle: 3.14, anchor: Anchor.center) {
    changeDirection(PacmanDirection.left);
  }

  @override
  void update(double dt) {
    caminar(dt);
    super.update(dt);
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
    add(RectangleHitbox(
        position: Vector2(-2, size.y / 2),
        size: Vector2(size.x / 8, size.y * 0.70),
        anchor: Anchor.center,
        isSolid: true)
      ..collisionType = CollisionType.active);
    add(RectangleComponent(
        position: Vector2(-2, size.y / 2),
        anchor: Anchor.center,
        size: Vector2(size.x / 8, size.y * 0.70 ),
        paint: white));
  }

  changeDirection(PacmanDirection direction) {
    if (_pacmanDirection == PacmanDirection.quite &&
            _pacmanLastDirection == direction ||
        _pacmanDirection == direction) return;
    if (direction != PacmanDirection.quite) {
      angle = directions[direction]!;
    }
    _pacmanLastDirection = _pacmanDirection;
    _pacmanDirection = direction;
  }

  caminar(dt) {
    switch (_pacmanDirection) {
      case PacmanDirection.up:
        position.y -= pxs * dt;
        break;
      case PacmanDirection.down:
        position.y += pxs * dt;
        break;
      case PacmanDirection.right:
        position.x += pxs * dt;
        break;
      case PacmanDirection.left:
        position.x -= pxs * dt;
        break;
      case PacmanDirection.quite:
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Wall) {
      changeDirection(PacmanDirection.quite);
    }
    super.onCollision(intersectionPoints, other);
  }
}
