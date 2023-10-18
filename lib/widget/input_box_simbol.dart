import 'package:flutter/material.dart';

class InputerBoxSimbol extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double width;
  final double height;
  final double inputHeight;
  final bool isNumeric;

  const InputerBoxSimbol({
    super.key,
    this.controller,
    required this.labelText,
    this.borderColor = const Color(0xFFb4b4b4),
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.width = 450,
    this.height = 40,
    this.inputHeight = 30,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(height: 10),
        ),
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFf6f6f6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 13),
                prefix: Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
