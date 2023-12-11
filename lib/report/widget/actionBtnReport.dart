import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/report/widget/CustomTabButton.dart';
import 'package:housekeepingmanagement/report/widget/monthly.dart';
import 'package:housekeepingmanagement/report/widget/table.dart';
import 'package:housekeepingmanagement/report/widget/weekly.dart';
import 'package:housekeepingmanagement/report/widget/yearly.dart';

class ActionBtnReport extends StatefulWidget {
  @override
  _ActionBtnReportState createState() => _ActionBtnReportState();
}

class _ActionBtnReportState extends State<ActionBtnReport> {
  int currentViewIndex = 0;

  void _changeView(int index) {
    setState(() {
      currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
            Stack(
        children: [
          Positioned.fill(
            child: getView(currentViewIndex),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Row(
              children: [
         CustomTabButton(
  text: "Daily",
  index: 0,
  currentViewIndex: currentViewIndex,
  onPressed: _changeView,
),SizedBox(width:20),
  CustomTabButton(
  text: "Weekly",
  index: 1,
  currentViewIndex: currentViewIndex,
  onPressed: _changeView,
),SizedBox(width:20),   CustomTabButton(
  text: "Monthly",
  index: 2,
  currentViewIndex: currentViewIndex,
  onPressed: _changeView,
),SizedBox(width:20),  
  CustomTabButton(
  text: "Yearly",
  index: 3,
  currentViewIndex: currentViewIndex,
  onPressed: _changeView,
),
         ],
            ),
          ),
        ],
        );
  }

  Widget getView(int index) {
    switch (index) {
      case 0:
        return  Container(
            margin: EdgeInsets.only(top:32,left:10,right:10,bottom:10),
            padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
            decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    
  ),
            child:dailyReport()
        );
      case 1:
      return  Container(
            margin: EdgeInsets.only(top:32,left:10,right:10,bottom:10),
            padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
            decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    
  ),
            child:weeklyReport()
        );
      case 2:
        return Container(
            margin: EdgeInsets.only(top:32,left:10,right:10,bottom:10),
            padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
            decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    
  ),
            child:monthReport()
        );
      case 3:
        return Container(
            margin: EdgeInsets.only(top:32,left:10,right:10,bottom:10),
            padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
            decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
    
  ),
            child:yearlyReport()
        );
      default:
        return Container(); // Handle unexpected cases
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ActionBtnReport(),
  ));
}
