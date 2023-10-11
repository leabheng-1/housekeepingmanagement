import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';

Widget buildLabelAndContent(String label, List<Widget> content, VoidCallback action) {
  return Stack(
    clipBehavior: Clip.none, // Set clip to false to allow overlapping
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    ...content,
                  ],
                ),
              ),
            ],
          ),
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
              color: ColorController.barColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
      Positioned(
  top: 10,
  right: 10,
  child: Container(
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      color: ColorController.barColor, // Set the background color here
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
    ),
    child: IconButton(
      onPressed: action,
      icon: Icon(Icons.edit),
      color: Colors.blue,
      iconSize: 16, // Customize the button color as needed
    ),
  ),
)

    ],
  );
}
