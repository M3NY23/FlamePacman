import 'package:flame/components.dart';
import 'package:pacman/game/providers/world_map_provider.dart';

class WorldMap extends PositionComponent {
  final worldMapProvider = WorldMapProvider();

  WorldMap(
      {required Vector2 position, required Vector2 size})
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await _drawMap();
    super.onLoad();
  }

  Future<void> _drawMap() async {
    for (var element in worldMapProvider.worldMapComponentList) {
      add(element);
    }
  }
}
