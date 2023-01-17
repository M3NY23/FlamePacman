import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:pacman/game/components/pacman/pacman.dart';

enum MouthState { onOpen, onClose }

class PacmanMouth extends PolygonComponent {
  static Paint black = BasicPalette.black.paint();

  double startMouth = 0, endMouth = 0, parentMid = 0;
  MouthState mouthState = MouthState.onClose;

  PacmanMouth({required double pacmanRadius})
      : super(
          [Vector2(0, 0), Vector2(0, 0), Vector2(0, 0)],
          paint: black,
        ) {
    endMouth = pacmanRadius * 2;
    parentMid = pacmanRadius;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    refreshVertices(newVertices: [
      Vector2(0, startMouth),
      Vector2(0, endMouth),
      Vector2(parentMid, parentMid)
    ]);
  }

  @override
  void update(double dt) async {
    _moveMouth();
    super.update(dt);
  }

  _moveMouth() {
    switch (mouthState) {
      case MouthState.onOpen:
        endMouth++;
        startMouth--;
        if (startMouth <= 0) {
          mouthState = MouthState.onClose;
        }
        break;
      case MouthState.onClose:
        endMouth--;
        startMouth++;
        if (startMouth >= parentMid) {
          mouthState = MouthState.onOpen;
        }
        break;
    }

    refreshVertices(newVertices: [
      Vector2(0, startMouth),
      Vector2(0, endMouth),
      Vector2(parentMid, parentMid)
    ]);
  }
}
