import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  const CustomButton({
    super.key,
    required this.text,
    this.width = 220,
    this.height = 50,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Stack(
          children: [
            Positioned(
              top: 4,
              child: Container(
                width: width,
                height: height - 15,
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: width,
              height: height - 15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Press',
                    shadows: [
                      Shadow(color: Colors.red[900]!, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
