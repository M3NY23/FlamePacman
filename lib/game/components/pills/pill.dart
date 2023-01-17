import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Pill extends PositionComponent with CollisionCallbacks {
  static Paint pillColor = BasicPalette.white.paint();

  Pill({required Vector2 position, required double size})
      : super(position: position, size: Vector2.all(size));

  @override
  Future<void> onLoad() async {
    initPill();
    super.onLoad();
  }

  initPill() {
    add(CircleComponent(
        radius: size.x / 5,
        paint: pillColor,
        position: size / 2,
        anchor: Anchor.center));
    add(CircleHitbox(
        radius: size.x / 5, position: size / 2, anchor: Anchor.center));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    removeFromParent();
    super.onCollision(intersectionPoints, other);
  }
}
