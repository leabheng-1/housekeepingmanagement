import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_list/data_check_in_list.dart';
import 'package:housekeepingmanagement/data_list/data_check_out_list.dart';
import 'package:housekeepingmanagement/widget/current_date.dart';
import 'package:housekeepingmanagement/widget/dashboard_today.dart';
import 'package:housekeepingmanagement/widget/guest_chart.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 600 ? 160.0 : 120.0;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: <Widget>[
                DashboardToday(),
                const SizedBox(
                  width: 40,
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 39, 154, 248),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: GuestChart(),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                const CurrentDate(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: buttonWidth,
                child: TextButton(
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
                            ? Colors.blue.shade200
                            : Colors.grey.shade400;
                      },
                    ),
                  ),
                  child: Text(
                    "CHECK-IN",
                    style: TextStyle(
                      color: listviewClicked ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 40,
                width: buttonWidth,
                child: TextButton(
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
                            ? Colors.blue.shade200
                            : Colors.grey.shade400;
                      },
                    ),
                  ),
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
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 10, bottom: 20, top: 10),
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
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return AnimatedSwitcher(
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
    );
  }
}
