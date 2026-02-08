import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(
          255, 1, 15, 28), // Dark navy color similar to the image
    );
  }
}
