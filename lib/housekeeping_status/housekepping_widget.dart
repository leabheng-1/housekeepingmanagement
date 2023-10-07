import 'package:flutter/material.dart';

class HouseKeepingWidget extends StatelessWidget {
  final Icon icon;

  final String title;
  final int value;
  final Color backgroundColor;
  final Color iconbackground;

  const HouseKeepingWidget({
    Key? key,
    required this.icon,
    required this.value,
    required this.title,
    required this.backgroundColor,
    required this.iconbackground,
// Initialize iconSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width > 600 ? 300 : 240;

    return Container(
      width: containerWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconbackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
