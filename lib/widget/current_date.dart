import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDate extends StatelessWidget {
  final double height;
  final double width;

  const CurrentDate({
    Key? key,
    this.height = 250,
    this.width = 350,
  }) : super(key: key);

  String getCurrentDate(DateTime now) {
    final formattedDate = DateFormat('dd | MMM | yyyy').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[
          Container(
            height: height * 0.208,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // First Column
    Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('E').format(now),
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
    ),
    // Second Column
    SizedBox(width: 30), // Adjust the width as needed for the space
    Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${now.year}",
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  ],
),

            ),
          ),
          Container(
            height: height * 0.792,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child:
             Center(
                child:
             Row(
              children: [
                SizedBox(width: 55,),
                SizedBox(
                  child: Text(
                    "${now.day}",
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 70),
                  ),
                ),
                SizedBox(width:80,),
                SizedBox(
                  child: Text(
                    " ${DateFormat('MMM').format(now)}",
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.black87,
                    ),
                  ),
                )
              ],
            ),
          ),
          )
        ],
      ),
    );
  }
}
