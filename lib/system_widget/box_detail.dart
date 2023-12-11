import 'package:flutter/material.dart';

class Boxdetail extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final double borderRadius;
  final double width;
  final double height;
  final Color? textColor;  // Change Color to Color?

  const Boxdetail({
    Key? key,
    required this.title,
    required this.value,
    this.backgroundColor = const Color(0xFFF6F6F6),
    this.borderRadius = 10.0,
    this.width = 450,
    this.textColor,  // Change Color to Color?
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(height: 10),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
      
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: textColor ?? Colors.black,  // Use textColor, or fallback to black
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
