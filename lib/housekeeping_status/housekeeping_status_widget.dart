import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HouseKeepingStatus extends StatelessWidget {
  final String title;
  final IconData icon;
  Color backgroundColor;

  HouseKeepingStatus({
    Key? key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
