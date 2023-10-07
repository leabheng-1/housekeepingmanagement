import 'package:flutter/material.dart';

Widget buildLabelAndContent(String label, List<Widget> content) {
  return Stack(
    clipBehavior: Clip.none, // Set clip to false to allow overlapping
    children: [
      Container(
        width: 600,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
  padding: EdgeInsets.only(left:20,right:20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left) of the Column
    children: [
      SizedBox(height: 30),
      ...content,
    ],
  ),
)

          ],
        ),
      ),
      Positioned(
        top: -20, // Adjust this value to control the overlap
        left: 20,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 200, // Set the maximum width for the label
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.red), // Set border details here
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.only(left:15,right:15,top:8,bottom:8),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}
