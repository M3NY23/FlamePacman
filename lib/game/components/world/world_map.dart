import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/game/components/pacman/pacman.dart';
import 'package:pacman/game/components/pills/pill.dart';
import 'package:pacman/game/components/walls/wall.dart';

class WorldMap extends PositionComponent {

  final Pacman pacman;

  WorldMap({required Vector2 position, required Vector2 size, required this.pacman})
      : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final worldMapString = await _loadMap();
    await _drawMap(worldMapString);
    super.onLoad();
  }

  Future<String> _loadMap() async {
    return await rootBundle.loadString('assets/docs/map.txt');
  }

  Future<void> _drawMap(String worldMapString) async {
    List<String> rowColumn = [];
    List<String> mapRows = worldMapString.split('\n');

    double wallSize = size.x / mapRows[0].length;
    double xPos = 0, yPos = 0;

    for (int i = 0; i < mapRows.length; i++) {
      rowColumn = List<String>.generate(
          mapRows[i].length, (index) => mapRows[i][index]);
      for (int j = 0; j < rowColumn.length; j++) {
        switch (rowColumn[j]) {
          case '#':
            add(Wall(position: Vector2(xPos, yPos), size: wallSize));
            break;
          case 'P':
            pacman.radius = wallSize / 2;
            pacman.position = Vector2(xPos, yPos+pacman.radius);
            add(pacman);
            break;
          case '*':
            add(Pill(position: Vector2(xPos, yPos), size: wallSize));
            break;
          default:
        }
        xPos += wallSize;
      }
      yPos += wallSize;
      xPos = 0;
    }
  }
}
