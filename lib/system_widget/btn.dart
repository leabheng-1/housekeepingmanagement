import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final IconData iconData;
  final double iconSize;
  final Color buttonBackgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color textColor;
  const CustomButton(
      {super.key,
      required this.title,
      this.titleFontSize = 16.0,
      required this.iconData,
      this.iconSize = 24.0,
      this.buttonBackgroundColor = const Color.fromARGB(50, 33, 149, 243),
      this.iconBackgroundColor = const Color(0xFFC9FFD7),
      this.iconColor = Colors.white,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3, right: 14, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: buttonBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(3.0),
            child: Icon(
              iconData,
              color: iconColor,
              size: iconSize,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: titleFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
