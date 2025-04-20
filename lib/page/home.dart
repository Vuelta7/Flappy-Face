import 'package:file_picker/file_picker.dart';
import 'package:flame/game.dart';
import 'package:flappy_face/page/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: ADD DESIGN
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );

                if (result != null && result.files.single.path != null) {
                  String path = result.files.single.path!;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('face_path', path); // save image path

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              GameWidget(game: FlappyFaceGame(imagePath: path)),
                    ),
                  );
                }
              },
              child: Text('Pick A Picture'),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? savedPath = prefs.getString('face_path');

                if (savedPath != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => GameWidget(
                            game: FlappyFaceGame(imagePath: savedPath),
                          ),
                    ),
                  );
                } else {
                  // maybe show error or ask user to pick image first
                  print('nigga');
                }
              },
              child: Text('Play Game'),
            ),
          ],
        ),
      ),
    );
  }
}
