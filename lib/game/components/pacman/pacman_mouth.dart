import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:pacman/game/components/pacman/pacman.dart';

enum MouthState { onOpen, onClose }

class PacmanMouth extends PolygonComponent {
  static Paint black = BasicPalette.black.paint();

  double startMouth = 0, endMouth = 0, parentMid = 0;
  MouthState mouthState = MouthState.onClose;

  PacmanMouth()
      : super(
          [Vector2(0, 0), Vector2(0, 0), Vector2(0, 0)],
          paint: black,
        ) {
    endMouth = Pacman.playerRadius * 2;
    parentMid = Pacman.playerRadius;
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
        if (endMouth == parentMid || startMouth == 0) {
          mouthState = MouthState.onClose;
        }
        break;
      case MouthState.onClose:
        endMouth--;
        startMouth++;
        if (endMouth == parentMid || startMouth == parentMid) {
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
