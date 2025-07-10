import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Jump Game',
      theme: ThemeData.dark(),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  double playerY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = 1;
  bool isGameStarted = false;
  List<double> obstacleX = [2, 3.5];
  final double obstacleWidth = 0.2;
  Timer? gameTimer;
  int score = 0;
  bool gameOver = false;
  final double maxJumpHeight = -0.5; // upper limit

  void jump() {
    setState(() {
      time = 0;
      initialHeight = playerY;
    });
  }

  void startGame() {
    isGameStarted = true;
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 3.0 * time; // reduced jump power
      setState(() {
        playerY = initialHeight - height;

        // Prevent chick from going too high
        if (playerY < maxJumpHeight) {
          playerY = maxJumpHeight;
        }

        for (int i = 0; i < obstacleX.length; i++) {
          obstacleX[i] -= 0.05;
        }
      });

      for (int i = 0; i < obstacleX.length; i++) {
        if (obstacleX[i] < -1.5) {
          obstacleX[i] += 3.5;
          score++;
        }
      }

      if (checkCollision()) {
        endGame();
      }
    });
  }

  void endGame() {
    gameTimer?.cancel();
    setState(() {
      gameOver = true;
      isGameStarted = false;
    });
  }

  void resetGame() {
    setState(() {
      playerY = 1;
      time = 0;
      height = 0;
      initialHeight = 1;
      obstacleX = [2, 3.5];
      score = 0;
      gameOver = false;
      isGameStarted = false;
    });
  }

  bool checkCollision() {
    for (double obsX in obstacleX) {
      if (obsX < 0.2 && obsX > -0.2 && playerY >= 0.9) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameOver) {
          resetGame();
        } else if (!isGameStarted) {
          startGame();
        } else {
          jump();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/sky.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment(0, playerY),
              child: Image.asset(
                'assets/images/chick.png',
                height: 60,
              ),
            ),
            for (double obsX in obstacleX)
              Obstacle(x: obsX, width: obstacleWidth),
            Align(
              alignment: const Alignment(0, 1),
              child: Image.asset(
                'assets/images/ground.jpg',
                fit: BoxFit.fill,
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            if (gameOver)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: resetGame,
                        child: const Text('Restart'),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class Obstacle extends StatelessWidget {
  final double x; // alignment from -2 to 2
  final double width;

  const Obstacle({super.key, required this.x, required this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: (x + 1) * MediaQuery.of(context).size.width / 2,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red.shade800,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
