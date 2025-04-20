import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_face/components/background.dart';
import 'package:flappy_face/components/constant.dart';
import 'package:flappy_face/components/face.dart';
import 'package:flappy_face/components/ground.dart';
import 'package:flappy_face/components/pipe.dart';
import 'package:flappy_face/components/pipe_manager.dart';
import 'package:flappy_face/components/score.dart';
import 'package:flappy_face/page/home.dart';
import 'package:flutter/material.dart';

class FlappyFaceGame extends FlameGame with TapDetector, HasCollisionDetection {
  /*
  
  basic game components:
  -bird
  -background
  -ground
  -pipes
  -score

  */

  final String imagePath;

  late Face face;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  //load
  @override
  FutureOr<void> onLoad() {
    //load background
    background = Background(size);
    add(background);

    //load face
    face = Face(imagePath);
    add(face);

    //load ground
    ground = Ground();
    add(ground);

    //load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    //load scores
    scoreText = ScoreText();
    add(scoreText);
  }

  //tap
  @override
  void onTap() {
    face.flap();
  }

  //scores
  int score = 0;
  void incrementScore() {
    score += 1;
  }

  //gameover
  bool isGameOver = false;

  FlappyFaceGame({
    super.children,
    super.world,
    super.camera,
    required this.imagePath,
  });

  void gameOver() {
    // prevent multiple game over triggers
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      barrierDismissible: false,
      context: buildContext!,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Over'),
            content: Text("High Score: $score"),
            actions: [
              TextButton(
                onPressed: () {
                  //pop box
                  Navigator.pop(context);
                  //reset game
                  resetGame();
                },
                child: const Text('Restart'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Home'),
              ),
            ],
          ),
    );
  }

  void resetGame() {
    face.position = Vector2(birdStartX, birdStartY);
    face.velocity = 0;
    score = 0;
    isGameOver = false;
    //remove all the pipes
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
