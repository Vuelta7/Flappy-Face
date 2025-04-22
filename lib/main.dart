import 'package:flappy_face/page/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          shape: const StadiumBorder(),
          backgroundColor: Colors.cyan,
          contentTextStyle: TextStyle(
            fontFamily: 'Press',
            fontSize: 16,
            color: Colors.white,
            shadows: [Shadow(color: Colors.red[900]!, offset: Offset(2, 2))],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      ),
    );
  }
}
