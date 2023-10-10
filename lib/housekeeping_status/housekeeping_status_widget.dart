import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconWithLabel extends StatelessWidget {
  final IconData iconData;
  final String? label;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  IconWithLabel({
    required this.iconData,
    this.label,
    this.backgroundColor = Colors.blue, // Default background color
    this.iconColor = Colors.white, // Default icon color
    this.iconSize = 16.0, // Default icon size
  });

  @override
  Widget build(BuildContext context) {
    return Container(          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(10.0), // Adjust padding as needed
  
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          ),
          ),
          if (label != null) // Display label only if it's not null
            SizedBox(width: 10.0), // Space between icon and label
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 16.0, // Text size
              ),
            ),
        ],
      ),
    );
  }
}

class HouseKeepingStatus extends StatelessWidget {
  final String title;
  final IconData icon;
  Color backgroundColor;
final Color iconColor;
  final double iconSize;
  HouseKeepingStatus({
    Key? key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
     this.iconColor = Colors.white, // Default icon color
    this.iconSize = 16.0, // Default icon size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(10.0), // Adjust padding as needed
  
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          ),
          if (title != null) // Display label only if it's not null
            SizedBox(width: 10.0), // Space between icon and label
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 16.0, // Text size
              ),
            ),
        ],
      ),
    );
  }
}
