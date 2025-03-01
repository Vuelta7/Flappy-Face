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
    face = Face();
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

  void gameOver() {
    // prevent multiple game over triggers
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
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
