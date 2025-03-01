import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_face/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyFaceGame> {
  //init
  ScoreText()
    : super(
        text: '0',
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.grey, fontSize: 50),
        ),
      );

  //load
  @override
  FutureOr<void> onLoad() {
    //set the position to lower middle
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50,
    );
  }

  //update
  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }
}
