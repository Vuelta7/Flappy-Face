import 'dart:async';

import 'package:flame/components.dart';

class Background extends SpriteComponent {
  //init background position and size
  Background(Vector2 size) : super(size: size, position: Vector2(0, 0));

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('background.png');
  }
}
