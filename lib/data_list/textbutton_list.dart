import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextButttonList extends StatelessWidget {
  String title = "";
  double height;
  double width;
  Color backgroundColor;

  TextButttonList(
      {super.key,
      required this.backgroundColor,
      required this.title,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () {},
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
