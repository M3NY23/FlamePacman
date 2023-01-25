import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pacman/game/providers/world_map_provider.dart';
import 'package:pacman/game/pacman_game.dart';
import 'package:pacman/overlays/main_menu.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late FlameGame game;
  late WorldMapProvider worldMapProvider = WorldMapProvider();

  @override
  void initState() {
    game = PacmanGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pacman',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: const BorderSide(color: Colors.white)))),
      home: GameWidget(
        loadingBuilder: (context) => const Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          ),
        ),
        game: PacmanGame(),
        overlayBuilderMap: {
          MainMenu.id: (_, PacmanGame gameRef) => MainMenu(game: gameRef)
        },
        // initialActiveOverlays: const [MainMenu.id],
      ),
    );
  }
}
