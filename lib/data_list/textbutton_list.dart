import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextButttonList extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color backgroundColor;
  final VoidCallback? onPressed; // Make the callback optional

  TextButttonList({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.height,
    required this.width,
    this.onPressed, // Make the callback optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: onPressed, // Use the provided callback if it's not null
        child: Container(
          height: MediaQuery.of(context).size.height * height,
          width: MediaQuery.of(context).size.width * width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
