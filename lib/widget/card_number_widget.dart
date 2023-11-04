import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardNumberWidget extends StatelessWidget {
  Icon icon;
  String title = "";
  int value = 0;
  Color backgroundColor;
  CardNumberWidget(
      {super.key,
      required this.icon,
      required this.value,
      required this.title,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: icon),
                const SizedBox(
                  width: 18,
                ), Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ),
                Text(
                  value.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
