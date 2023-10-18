import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesd_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      isLoading
          ? const Center(
              child: CircularProgressIndicator(), 
            )
          : Column(
              children: [
                Row(
                  children: [
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.checkInIcon,
                        color: Colors.white,
                      ),
                      title: "Check-In",
                      value: data?['checkin_count'],
                      backgroundColor: ColorController.checkInColor,
                      iconbackground: Colors.blue.shade800,
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
                      value: data?['count_arrival'] ?? '',
                      backgroundColor: ColorController.arrivalsColor,
                      iconbackground: Colors.purple.shade900,
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
                      value: data?['checkout_count'] ?? '',
                      backgroundColor: ColorController.checkOutColor,
                      iconbackground: Colors.orange.shade900,
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
                      value: data?['count_departure'] ?? '',
                      backgroundColor: ColorController.departuresColor,
                      iconbackground: Colors.grey.shade700,
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
                      value: data?['available_rooms'] ?? '',
                      backgroundColor: ColorController.availableColor,
                      iconbackground: Colors.blue.shade800,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.inHouseIcon,
                        color: Colors.white,
                      ),
                      title: "Inhouse",
                      value: data?['inHouse'] ?? '',
                      backgroundColor: ColorController.inhouse,
                      iconbackground: Colors.blue.shade800,
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                // Other rows and widgets...
              ],
            )
    ]);
  }
}
