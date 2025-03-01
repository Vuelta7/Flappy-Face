import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_face/components/constant.dart';
import 'package:flappy_face/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyFaceGame> {
  //determine if the pipe is top or bottom
  final bool isTopPipe;

  //score
  bool scored = false;

  //init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    : super(position: position, size: size);

  //load

  @override
  FutureOr<void> onLoad() async {
    //load sprite image
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    add(RectangleHitbox());
  }

  //update
  @override
  void update(double dt) {
    //scroll pipe to left
    position.x -= groundScrollingSpeed * dt;

    if (!scored && position.x + size.x < gameRef.face.position.x) {
      scored = true;

      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
