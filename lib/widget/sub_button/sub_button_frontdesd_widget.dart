import 'package:flutter/material.dart';

// ignore: must_be_immutable
 const Color defaultTextColor = Color(0xFFFFFFFF);
class SubButtonFrontdeskWidget extends StatelessWidget {
  Icon icon;
  String title = "";
  int value = 0;
  Color backgroundColor;
  Color iconbackground;
  Color textColor;
  SubButtonFrontdeskWidget(
      {super.key,
      required this.icon,
      required this.value,
      required this.title,
      required this.backgroundColor,
      this.iconbackground = const Color(0x66000000),
      this.textColor =defaultTextColor });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: 
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:5,top:5,bottom:5,right: 15 ),
            child: Row(
  children: [
    Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: iconbackground ,
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
          color: textColor ,
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
)

          ),
        ),
    );
  }
}
