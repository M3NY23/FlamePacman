import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:pacman/game/components/pacman/pacman.dart';

class PacmanGame extends FlameGame with HasTappableComponents, PanDetector {
  late Pacman player;
  // El escenario de pacman mide 31 * 28 cuadros
  @override
  Future<void> onLoad() async {
    player = Pacman(position: size / 2);
    add(player);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (info.raw.velocity.pixelsPerSecond.dx.abs() >
        info.raw.velocity.pixelsPerSecond.dy.abs()) {
      // horizontal event
      player.changeDirection(info.raw.velocity.pixelsPerSecond.dx < 0
          ? PacmanDirection.left
          : PacmanDirection.right);
    } else {
      // vertical event
      player.changeDirection(info.raw.velocity.pixelsPerSecond.dy < 0
          ? PacmanDirection.up
          : PacmanDirection.down);
    }
    super.onPanEnd(info);
  }
}
