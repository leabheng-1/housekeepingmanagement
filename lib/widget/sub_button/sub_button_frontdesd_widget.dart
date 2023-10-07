import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubButtonFrontdeskWidget extends StatelessWidget {
  Icon icon;
  String title = "";
  int value = 0;
  Color backgroundColor;
  Color iconbackground;
  SubButtonFrontdeskWidget(
      {super.key,
      required this.icon,
      required this.value,
      required this.title,
      required this.backgroundColor,
      required this.iconbackground});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 185,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: iconbackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: icon),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
