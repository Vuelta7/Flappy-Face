import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_face/constant.dart';
import 'package:flappy_face/game.dart';
import 'package:flappy_face/pipe.dart';

class PipeManager extends Component with HasGameRef<FlappyFaceGame> {
  //update -> every second (dt)
  //we will continuously spawn new pipes

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    const double pipeInterval = 2;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  //spawn pipes

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = 150;
    const double minPipeHeight = 50;
    const double pipeWidth = 60;

    //calculate pipe heights

    //max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    //height of bottom pipe -> randomly select between min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    //create bottom pipe
    final bottomPipe = Pipe(
      //position
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      //size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    //create top pipe
    final topPipe = Pipe(
      //position
      Vector2(gameRef.size.x, 0),
      //size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    //add both pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
