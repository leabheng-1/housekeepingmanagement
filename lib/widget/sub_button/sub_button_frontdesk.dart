import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/dialog/statusDialog.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesd_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skeletonizer/skeletonizer.dart';
class SubButtonFrontdesk extends StatefulWidget {
  const SubButtonFrontdesk({super.key});

  @override
  State<SubButtonFrontdesk> createState() => _SubButtonFrontdeskState();
}

class _SubButtonFrontdeskState extends State<SubButtonFrontdesk> {
  Map<String, dynamic>? apiResponse;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/todayStatus'));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        apiResponse = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = apiResponse != null ? apiResponse!['data'] : null;

    return Column(children: [
       Skeletonizer(
        enabled: isLoading,
        child: Column(
              children: [
                Row(
                  children: [
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.checkInIcon,
                        color: Colors.white,
                     
                      ),
                      title: "Check-In",
                      value: data?['checkin_count'] ?? 0,
                      backgroundColor: ColorController.checkInColor,
                       action: () {
                      
                         statusDialog(
                                                            context, fetchData , 'Today Check In')
                                                        .showCreatestatusDialog(
                                                            data['checkInBookings']);
                                            
                      
                        }
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        Icons.flight_land,
                        color: Colors.white,
                      ),
                      title: "Arrival",
                      value: data?['count_arrival'] ?? 0,
                      backgroundColor: ColorController.arrivalsColor,
                        action: () {
                      
                         statusDialog(
                                                            context, fetchData , 'Arrival')
                                                        .showCreatestatusDialog(
                                                            data['arrivalBookings']);
                                            
                      
                        }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.checkOutIcon,
                        color: Colors.white,
                      ),
                      title: "Check-Out",
                      value: data?['checkout_count'] ?? 0,
                      backgroundColor: ColorController.checkOutColor,
                      action:() {
                         statusDialog(
                                                            context, fetchData ,'Today Check Out')
                                                        .showCreatestatusDialog(
                                                            data['checkOutBookings']);
                                            
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        Icons.flight_takeoff,
                        color: Colors.white,
                      ),
                      title: "Departure",
                      value: data?['count_departure'] ?? 0,
                      backgroundColor: ColorController.departuresColor,
                         action: () {
                      
                         statusDialog(
                                                            context, fetchData , 'Departure')
                                                        .showCreatestatusDialog(
                                                            data['departureBookings']);
                                            
                      
                        }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        Icons.file_download_done,
                        color: Colors.white,
                      ),
                      title: "Available",
                      value: data?['available_rooms'] ?? 0,
                      backgroundColor: ColorController.availableColor,
                      action: () {
                      
                         statusDialog(
                                                            context, fetchData , 'Departure')
                                                        .showCreatestatusDialog(
                                                            data['availableRoomBooking']);
                                            
                      
                        }
                      
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.inHouseIcon,
                        color: Colors.white,
                      ),
                      title: "In-House",
                      value: data?['inHouse'] ?? 0,
                      backgroundColor: ColorController.inhouse,
                        action: () {
                      
                         statusDialog(
                                                            context, fetchData , 'Today In House')
                                                        .showCreatestatusDialog(
                                                            data['InhousetBookings']);
                                            
                      
                        }
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                // Other rows and widgets...
              ],
            )
    )]);
  }
}
