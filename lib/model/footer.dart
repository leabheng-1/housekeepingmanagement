import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class footer extends StatefulWidget {
  @override
  _RealTimeClockTextState createState() => _RealTimeClockTextState();
}

class _RealTimeClockTextState extends State<footer> {
  String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Working Date ${DateFormat('yyyy-MM-dd').format(DateTime.now())} | Time: $currentTime ",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // Update the time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      });
    });
  }
}
