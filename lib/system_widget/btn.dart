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
class BtnAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback? action; // Make action optional by using VoidCallback?

  final Color textColor;

  BtnAction({
    required this.icon,
    required this.color,
    required this.label,
    this.action, // Make action optional
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action, // Specify the onPressed callback function
      style: ElevatedButton.styleFrom(
        primary: color, // Set the background color with 50% opacity
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Adjust the button's border radius as needed
        ),
        padding: EdgeInsets.only(left: 5, top:13, bottom:13, right: 10), // Adjust padding as needed
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0), // Adjust the padding for the icon background
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5), // Background color for the icon with 50% opacity
            ),
            child: Icon(
              icon,
              color: Colors.white, // Icon color
            ),
          ),
          SizedBox(width: 8.0), // Add spacing between icon and label
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size as needed
              color: textColor, // Set the text color based on the parameter
            ),
          ),
        ],
      ),
    );
  }
}
