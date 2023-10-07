import 'package:flutter/material.dart';

class TextOnScreen extends StatelessWidget {
  const TextOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/image_back.png",
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
