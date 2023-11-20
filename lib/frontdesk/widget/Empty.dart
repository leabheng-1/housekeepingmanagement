import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  EmptyStateWidget({this.message = "No data available", this.icon = Icons.warning});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
  Container(
    width: 600, // Set the desired width
    height: 400, // Set the desired height
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 60, // Set your desired size
          color: Colors.grey,
        ),
        SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    ),
  ),
],

      ),
    );
  }
}
