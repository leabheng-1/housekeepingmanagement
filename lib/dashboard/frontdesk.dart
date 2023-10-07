import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/data_booking/add_booking_dialog.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_botton.dart';
import 'package:housekeepingmanagement/status/housekeeping_status.dart';
import 'package:housekeepingmanagement/status/room_status.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/calendat.dart';
import 'package:housekeepingmanagement/widget/search_widget.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesk.dart';

class FrontDesk extends StatefulWidget {
  const FrontDesk({super.key});

  @override
  State<FrontDesk> createState() => _FrontDeskState();
}

class _FrontDeskState extends State<FrontDesk> {
  bool listviewClicked = true;
  bool gridviewClicked = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddBookingDialog(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight >= 600 ? 60 : 40,
                        width: screenWidth >= 300 ? 400 : 200,
                        decoration: const BoxDecoration(
                          color: ColorController.othercolor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        width: screenWidth >= 600 ? 400 : 200,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Column(
                            children: [
                              TableCalendarWidget(),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SubButtonFrontdesk(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: Container(
                          height: screenHeight >= 600 ? 60 : 40,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            color: ColorController.othercolor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: RoomStatus(),
                                ),
                                const Expanded(
                                  child: HousekeepingStatus(),
                                ),
                                const Expanded(
                                  child: SearchWidget(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                listviewClicked = true;
                                                gridviewClicked = false;
                                              });
                                            },
                                            child: Icon(
                                              Icons.grid_view,
                                              color: listviewClicked
                                                  ? Colors.blue
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                listviewClicked = false;
                                                gridviewClicked = true;
                                              });
                                            },
                                            child: Icon(
                                              Icons.list_alt,
                                              color: gridviewClicked
                                                  ? Colors.blue
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: Container(
                          height: 500,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Column(
                children: [
                  HousekeepingButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
