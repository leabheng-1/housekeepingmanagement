import 'package:flutter/material.dart';

class CustomTabButton extends StatelessWidget {
  final String text;
  final int index;
  final int currentViewIndex;
  final Function(int) onPressed;

  CustomTabButton({
    required this.text,
    required this.index,
    required this.currentViewIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(index),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: currentViewIndex == index ? Color(0xFFDBEDF8) : Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: currentViewIndex == index ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
