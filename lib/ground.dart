import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_face/constant.dart';
import 'package:flappy_face/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyFaceGame>, CollisionCallbacks {
  // init

  Ground() : super();

  //load

  @override
  FutureOr<void> onLoad() async {
    //set size and position (2x width for infinite scroll)
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    //load ground sprite image
    sprite = await Sprite.load('ground.png');

    //add a collision box
    add(RectangleHitbox());
  }

  //update => every seconds
  @override
  void update(double dt) {
    // move to the left
    position.x -= groundScrollingSpeed * dt;

    // reset ground if goes off screen for infinite scroll
    // if half of ground has been passed, reset

    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
