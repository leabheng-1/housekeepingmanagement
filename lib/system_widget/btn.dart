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
      padding: const EdgeInsets.only(left: 3, right: 14, top: 3, bottom: 3),
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
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              iconData,
              color: iconColor,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 8.0),
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

class BtnAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback? action;
  final Color background;
  final Color textColor;

  const BtnAction({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    this.action,
    required this.textColor,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.only(left: 5, top: 13, bottom: 13, right: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: background,
            ),
            child: Icon(
              icon,
<<<<<<< HEAD
              size: 15,
              color: Colors.white, // Icon color
=======
              size: 20,
              color: Colors.white,
>>>>>>> 5e97334138f456cd8f8a5492783cade513e66994
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
