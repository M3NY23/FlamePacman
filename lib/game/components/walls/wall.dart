import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/components/world/world_map_component.dart';

class Wall extends WorldMapComponent {
  static Paint wallColor = BasicPalette.darkBlue.paint();
  static const collisionPadding = 2;

  Wall(
      {required super.position,
      required super.size,
      required super.xCoord,
      required super.yCoord});

  @override
  Future<void> onLoad() async {
    init();
    super.onLoad();
  }

  init() {
    var principalComponent =
        RectangleComponent.square(paint: wallColor, size: size.x);
    add(principalComponent);
    add(RectangleHitbox(
      isSolid: true,
      size: Vector2(size.x - collisionPadding, size.y - collisionPadding),
      position: principalComponent.size / 2,
      anchor: Anchor.center,
    ));
    // add(RectangleComponent(
    //   size: Vector2(size.x - collisionPadding, size.y - collisionPadding),
    //   position: principalComponent.size / 2,
    //   anchor: Anchor.center,
    //   paint: BasicPalette.white.paint(),
    // ));
  }
}
