import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  static const id = 'MainMenu';

  final FlameGame game;

  const MainMenu({super.key, required this.game});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {

  double buttonWidth = 120;

  late Animation<double> logoAnimation;
  late AnimationController logoAnimationController;
  late double logoHeight = 0;
  

  @override
  void initState() {
    super.initState();
    logoHeight = 100;
    logoAnimationController = AnimationController(
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 2),
        vsync: this);
    logoAnimation =
        Tween<double>(begin: 0.85, end: 0.90).animate(logoAnimationController)
          ..addListener(() {
            if (logoAnimationController.isCompleted) {
              logoAnimationController.repeat(reverse: true);
            }
            setState(() {});
          });
    logoAnimationController.forward();
  }

  @override
  void dispose() {
    logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/logo_pacman.png',
                  width:
                      MediaQuery.of(context).size.width * logoAnimation.value),
            ],
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: buttonWidth,
            child: OutlinedButton(
                onPressed: () => debugPrint('Empezando juego'),
                child: const Text('Start')),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: buttonWidth,
            child: OutlinedButton(
                onPressed: () => debugPrint('Configuraciones'),
                child: const Text('Settings')),
          )
        ],
      ),
    );
  }
}
