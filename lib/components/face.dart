import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_face/constant.dart';
import 'package:flappy_face/game.dart';
import 'package:flappy_face/ground.dart';

class Face extends SpriteComponent with CollisionCallbacks {
  //init face

  //initialize bird position & size
  Face()
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
    sprite = await Sprite.load('face.jpg');

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

    //check if the bird collides with ground
    if (other is Ground) {
      (parent as FlappyFaceGame).gameOver();
    }
  }
}
