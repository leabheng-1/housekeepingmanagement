

import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';

class IconButtonWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor; // Add a parameter for the icon color
  final Color labelColor; // Add a parameter for the label text color
  final Color buttonBackgroundColor; // Add a parameter for the button background color
  final VoidCallback action;
  

  IconButtonWithLabel({
    required this.icon,
    required this.label,
    required this.iconColor, // Include the icon color parameter
    required this.labelColor, // Include the label text color parameter
    required this.buttonBackgroundColor, // Include the button background color parameter
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(left:10,right:50,top:20,bottom:20), // Adjust padding as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Set border radius to 10
          ),
          backgroundColor: buttonBackgroundColor, // Set the background color of the button
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
             
              icon,
              color: iconColor, // Set the color of the icon 
              size: 30,
            ),
            SizedBox(width: 15), // Add spacing between icon and label
            Text(
              label,
              style: TextStyle(
                color: labelColor, // Set the color of the label text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBookingDialog extends StatelessWidget {
  final VoidCallback action;
  final Key? key; // Add a named 'key' parameter

  AddBookingDialog({
    required this.action,
    this.key, // Include the 'key' parameter in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
     IconButtonWithLabel(
      icon: Icons.add_circle,
      label: 'Add Booking',
      iconColor: Colors.white,
      labelColor: Colors.white,
      buttonBackgroundColor: ColorController.btnBookingColor,
      action: () {
        action();
      },
    )
      ],
    );
   
  }
}

class AddGroupBookingDialog extends StatelessWidget {
  final VoidCallback action;
  final Key? key; // Add a named 'key' parameter

  AddGroupBookingDialog({
    required this.action,
    this.key, // Include the 'key' parameter in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
        IconButtonWithLabel(
      icon: Icons.add_circle,
      label: 'Add Group Booking',
      iconColor: Colors.white,
      labelColor: Colors.white,
      buttonBackgroundColor: const Color.fromARGB(255, 133, 216, 255),
      action: () {
        action();
      },
    ),
      ],
    );
   
  }
}

