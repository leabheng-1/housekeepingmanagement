import 'package:flutter/material.dart';

class Boxdetail extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final double borderRadius;
  final double width;
  final double height;

  const Boxdetail(
      {super.key,
      required this.title,
      required this.value,
      this.backgroundColor = const Color(0xFFF6F6F6),
      this.borderRadius = 10.0,
      required this.width,
      this.height = 40});

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
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
