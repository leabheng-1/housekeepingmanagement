import 'package:flutter/material.dart';

class Boxdetail extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final double borderRadius;
  final double width;
  final double height;

  Boxdetail(
      {required this.title,
      required this.value,
      this.backgroundColor =
          const Color(0xFFF6F6F6), // Default background color
      this.borderRadius = 10.0, // Default border radius
      this.width = 450, // Default margin
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 10), // Set margin around the SizedBox
            child: SizedBox(height: 10), // Add spacing here
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
