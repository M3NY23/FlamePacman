import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/components/pacman/pacman.dart';
import 'package:pacman/game/components/world/world_map_component.dart';

class Pill extends WorldMapComponent with CollisionCallbacks {
  static Paint pillColor = BasicPalette.white.paint();

  Pill(
      {required super.position,
      required super.size,
      required super.xCoord,
      required super.yCoord});

  @override
  Future<void> onLoad() async {
    initPill();
    super.onLoad();
  }

  initPill() {
    add(CircleComponent(
        radius: size.x / 6,
        paint: pillColor,
        position: size / 2,
        anchor: Anchor.center));
    add(RectangleHitbox(
        size: size /2, position: size / 2, anchor: Anchor.center));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Pacman) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
