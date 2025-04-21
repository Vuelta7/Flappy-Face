import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flame/game.dart';
import 'package:flappy_face/page/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imagePath;

  @override
  void initState() {
    super.initState();
    loadImagePath();
  }

  void loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('face_path');
    });
  }

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
            Text('Image input:'),
            imagePath != null
                ? Image.file(File(imagePath!), height: 150)
                : Text('No image selected'),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );

                if (result != null && result.files.single.path != null) {
                  String path = result.files.single.path!;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('face_path', path);
                  setState(() {
                    imagePath = path;
                  });
                }
              },
              child: Text('Pick A Picture'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (imagePath != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => GameWidget(
                            game: FlappyFaceGame(imagePath: imagePath!),
                          ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please pick an image first')),
                  );
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
