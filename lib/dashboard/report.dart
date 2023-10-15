import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/PieChartReport.dart';
import 'package:housekeepingmanagement/report/widget/chart.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RowLayout(),
      ),
    );
  }
}

class RowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
     child: Container(
        padding: EdgeInsets.all(10),
        height: 900,
        child:
    Column(
      children: <Widget>[
        // Row 1 with flex 4
        Expanded(
          flex: 4,
          child: Row(
            children: <Widget>[
              // First column
              Expanded(
  flex: 6,
  child: Stack(
    children: <Widget>[
      Padding(
  padding: EdgeInsets.all(16.0), // Adjust the padding as needed
  child: Container(
    color: Colors.blue,
    child: Center(
      child: chart_bar_report(),
    ),
  ),
),

      Positioned(
        top: 10,  // Adjust the top value as needed for padding
        left: 10, // Adjust the left value as needed for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Small Title",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Big Title",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  ),
),
Expanded(
  flex: 4,
  child: Stack(
    children: <Widget>[
      Container( // Adjust the margin as needed
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              offset: Offset(0, 2), // Offset
              blurRadius: 4, // Blur radius
            ),
          ],
        ),
        child: Center(
          child: PieChartreport(),
        ),
      ),
      Positioned(
        top: 10,  // Adjust the top value as needed for padding
        left: 10, // Adjust the left value as needed for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Small Title",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Big Title",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  ),
)

            ],
          ),
        ),
        
        // Row 2 with flex 6
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.orange,
            child: Center(
              child: Text('Row 2'),
            ),
          ),
        ),
      ],
    )
    )
    );
  }
}
