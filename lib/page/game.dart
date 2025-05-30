import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:flappy_face/utils/custom_button.dart';
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
    AudioPlayer().play(AssetSource('audio/scored.mp3'));
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
    AudioPlayer().play(AssetSource('audio/lose.mp3'));
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      barrierDismissible: false,
      context: buildContext!,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.cyan,
            shadowColor: Colors.red[900],
            elevation: 10,
            title: Text(
              'Game Over',
              style: TextStyle(
                fontFamily: 'Press',
                fontSize: 30,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.red[900]!, offset: Offset(2, 2)),
                ],
              ),
            ),
            content: Text(
              "High Score: $score",
              style: TextStyle(
                fontFamily: 'Press',
                fontSize: 16,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.red[900]!, offset: Offset(2, 2)),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  //pop box
                  Navigator.pop(context);
                  //reset game
                  resetGame();
                },
                child: CustomButton(text: 'Restart', color: Colors.red),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: CustomButton(text: 'Home', color: Colors.red),
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
