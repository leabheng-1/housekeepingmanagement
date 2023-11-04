import 'package:flutter/material.dart';

Widget boxdetailwidget(
  Widget content, {
  Color backgroundColor = const Color.fromARGB(255, 255, 255, 255),
  EdgeInsets padding = const EdgeInsets.only(top: 10.0, left: 25.0),
}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           content,
      ],
    ),
  );
}
