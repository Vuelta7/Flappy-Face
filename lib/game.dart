import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_face/background.dart';
import 'package:flappy_face/components/face.dart';
import 'package:flappy_face/constant.dart';
import 'package:flappy_face/ground.dart';
import 'package:flappy_face/pipe_manager.dart';
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
  }

  //tap

  @override
  void onTap() {
    face.flap();
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
    isGameOver = false;
    resumeEngine();
  }
}
