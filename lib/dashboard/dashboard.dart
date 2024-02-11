import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dashboard/boxwidget.dart';
import 'package:housekeepingmanagement/data_list/data_check_in_list.dart';
import 'package:housekeepingmanagement/data_list/data_check_out_list.dart';
import 'package:housekeepingmanagement/widget/current_date.dart';
import 'package:housekeepingmanagement/widget/dashboard_today.dart';
import 'package:housekeepingmanagement/widget/guest_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool listviewClicked = true;
  bool gridviewClicked = false;

  Future<List<String>> fetchCheckInData() async {
    await Future.delayed(const Duration(seconds: 2));
    return ['Check-In Data 1', 'Check-In Data 2', 'Check-In Data 3'];
  }

  Future<List<String>> fetchCheckOutData() async {
    await Future.delayed(const Duration(seconds: 2));
    return ['Check-Out Data 1', 'Check-Out Data 2', 'Check-Out Data 3'];
  }

  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
     child: Container(
        padding: EdgeInsets.all(10),
        height: 950,
        child: Column(
          children: <Widget>[
            // First Row with 30% height
            Expanded(
              flex: 3, // 30% height
              child: Row(
                children: <Widget>[
                 Expanded(
  flex: 2, // 1/3 of the first row
  child: boxdetailwidget(DashboardToday())
),


                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1, // 1/3 of the first row
                    child: boxdetailwidget(GuestChart(),backgroundColor:Color.fromARGB(255, 109, 87, 255))
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1, // 1/3 of the first row
                    child:  boxdetailwidget(CurrentDate())
                  ),
                ],
              ),
            ),
            // Second Row with 70% height
            SizedBox(
                    height: 15,
                  ),
            Expanded(
              flex: 7, // 70% height
              child: Container(
                child:Column(
            children: [
    Row(
      children: [
        SizedBox(width: 20,),
        TextButton(
          onPressed: () {
            setState(() {
              listviewClicked = true;
              gridviewClicked = false;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return listviewClicked
                    ? const Color(0xFFDBEDF8)
                    : Colors.grey.shade400;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Set the top-left corner radius
                  topRight: Radius.circular(20.0), // Set the top-right corner radius
                ),
              ),
            ),
          ),
          child: 
          Padding(
            padding: EdgeInsets.all(10.0), // Adjust the left and right padding here
            child: Text(
              "CHECK-IN",
              style: TextStyle(
                color: listviewClicked ? Colors.blue : Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width:10,),
        TextButton(
        onPressed: () {
          setState(() {
            listviewClicked = false;
            gridviewClicked = true;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return gridviewClicked
                  ? const Color(0xFFDBEDF8)
                  : Colors.grey.shade400;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), // Set the top-left corner radius
                topRight: Radius.circular(20.0), // Set the top-right corner radius
              ),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0), // Adjust the left and right padding here
          child: Text(
            "CHECK-OUT",
            style: TextStyle(
              color: gridviewClicked ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
      ],
    ),

Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: FutureBuilder<List<String>>(
                      future: listviewClicked
                          ? fetchCheckInData()
                          : fetchCheckOutData(),
                      builder: (context, snapshot) {if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return 
                           AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: listviewClicked
                                ? const DataCheckInList()
                                : const DataCheckOutList(),
                          );
                          
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    )
              ),
            ),
          ],
        ),
      )
    ); 
    
 
  }
}
