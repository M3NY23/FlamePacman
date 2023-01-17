import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent {

  static Paint wallColor = BasicPalette.blue.paint();

  Wall({required Vector2 position, required double size}) : super(
    position: position,
    size: Vector2.all(size)
  );

  @override
  Future<void> onLoad() async {
    init();
    super.onLoad();
  }

  init() {
    add(RectangleComponent.square(
      paint: wallColor,
      size: size.x));
    add(RectangleHitbox(
      isSolid: true
    ));
  }

}