import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/PieChartReport.dart';
import 'package:housekeepingmanagement/report/widget/actionBtnReport.dart';
import 'package:housekeepingmanagement/report/widget/chart.dart';
import 'package:housekeepingmanagement/report/widget/table.dart';


int currentYear = DateTime.now().year;
class Report extends StatelessWidget {
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
  flex: 7,
  child: Stack(
    children: <Widget>[
 Container(
  margin: EdgeInsets.all(10.0),
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    boxShadow: [
      BoxShadow(
        color: Colors.grey, // The color of the shadow
        blurRadius: 5.0,    // Adjust the blur radius as needed
        offset: Offset(0, 2), // Adjust the offset as needed
      ),
    ],
  ),
  child: Center(
    child: Padding(
      padding: EdgeInsets.all(10), // Adjust the padding as needed
      child:  
       chart_bar_report(),
    ),
  ),
),




      Positioned(
        top: 30,  // Adjust the top value as needed for padding
        left: 30, // Adjust the left value as needed for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Revenue",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "$currentYear",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  ),
),
Expanded(
  flex: 3,
  child:Stack(
    children: <Widget>[
 Container(
  margin: EdgeInsets.all(10.0),
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    boxShadow: [
      BoxShadow(
        color: Colors.grey, // The color of the shadow
        blurRadius: 5.0,    // Adjust the blur radius as needed
        offset: Offset(0, 2), // Adjust the offset as needed
      ),
    ],
  ),
  child: Center(
    child: Padding(
      padding: EdgeInsets.all(30), // Adjust the padding as needed
      child: PieChartreport(),
    ),
  ),
),




      Positioned(
        top: 30,  // Adjust the top value as needed for padding
        left: 30, // Adjust the left value as needed for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Guest",
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
          child: ActionBtnReport() 
        ),
      ],
    )
    )
    );
  }
}
