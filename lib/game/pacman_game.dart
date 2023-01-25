import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:pacman/game/components/pacman/pacman.dart';
import 'package:pacman/game/providers/world_map_provider.dart';

import 'components/world/world_map.dart';

class PacmanGame extends FlameGame
    with HasTappableComponents, PanDetector, HasCollisionDetection {
  final pacman = Pacman();
  final worldMapProvider = WorldMapProvider();

  @override
  void onMount() {
    add(WorldMap(position: Vector2(size.x / 2, size.y * 0.75), size: size)
      ..add(pacman));
    super.onMount();
  }

  // El escenario de pacman mide 31 * 28 cuadros
  @override
  Future<void> onLoad() async {
    await worldMapProvider.init(size.x, size.y);
    pacman.position = worldMapProvider.playerPosition;
    pacman.radius = worldMapProvider.playerRadius;
    super.onLoad();
  }

  @override
  void onPanDown(DragDownInfo info) {
    pacman.changeDirection(PacmanDirection.quite);
    super.onPanDown(info);
  }

  @override
  void onPanStart(DragStartInfo info) {
    pacman.changeDirection(PacmanDirection.quite);
    super.onPanStart(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (info.raw.velocity.pixelsPerSecond.dx.abs() >
        info.raw.velocity.pixelsPerSecond.dy.abs()) {
      // horizontal event
      pacman.changeDirection(info.raw.velocity.pixelsPerSecond.dx < 0
          ? PacmanDirection.left
          : PacmanDirection.right);
    } else {
      // vertical event
      pacman.changeDirection(info.raw.velocity.pixelsPerSecond.dy < 0
          ? PacmanDirection.up
          : PacmanDirection.down);
    }
    super.onPanEnd(info);
  }
}
