import 'package:flutter/material.dart';

const Color defaultTextColor = Color(0xFFFFFFFF);

class SubButtonFrontdeskWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final int value;
  final Color backgroundColor;
  final Color iconbackground;
  final Color textColor;
  final VoidCallback? action;

  SubButtonFrontdeskWidget({
    Key? key,
    required this.icon,
    required this.value,
    required this.title,
    required this.backgroundColor,
    this.iconbackground = const Color(0x66000000),
    this.textColor = defaultTextColor,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        flex: 6,
        child:
        GestureDetector(
      onTap: () {
        if (action != null) {
          action!(); // Execute the action callback when tapped.
        }
      },child:
         Container(
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: iconbackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: icon,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        )
    );
  }
}
