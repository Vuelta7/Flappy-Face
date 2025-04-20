import 'dart:async';
import 'dart:io';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_face/components/constant.dart';
import 'package:flappy_face/components/ground.dart';
import 'package:flappy_face/components/pipe.dart';
import 'package:flappy_face/page/game.dart';
import 'package:flutter/material.dart';

class Face extends SpriteComponent with CollisionCallbacks {
  final String imagePath;
  //init face

  //initialize bird position & size
  Face(this.imagePath)
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeight),
      );

  //physical world properties
  double velocity = 0;

  //load

  @override
  FutureOr<void> onLoad() async {
    //load bird sprite image
    final imageFile = File(imagePath);
    final bytes = await imageFile.readAsBytes();
    final image = await decodeImageFromList(bytes);
    sprite = Sprite(image);

    //hit box
    add(RectangleHitbox());
  }

  //jump/flap
  void flap() {
    velocity = jumpStrength;
  }

  //update
  @override
  void update(double dt) {
    //apply gravity
    velocity += gravity * dt;

    //update face position based on the current velocity
    position.y += velocity * dt;
  }

  //collision => with another object

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    //check if the face collides with ground
    if (other is Ground) {
      (parent as FlappyFaceGame).gameOver();
    }

    //check if the face collides with pipes
    if (other is Pipe) {
      (parent as FlappyFaceGame).gameOver();
    }
  }
}
