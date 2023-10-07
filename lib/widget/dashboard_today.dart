import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'card_number_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';

class DashboardToday extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DashboardToday({Key? key});

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/todayStatus'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final data = snapshot.data!['data'];

          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 240,
                  width: 670,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                          icon: const Icon(
                                            Icons.bed_sharp,
                                            color: Colors.white,
                                          ),
                                          title: "Total Room",
                                          value: data['totalRoom'],
                                          backgroundColor:
                                              ColorController.totalroom)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                        icon: const Icon(
                                          Icons.dry_cleaning,
                                          color: Colors.white,
                                        ),
                                        title: "Dirty",
                                        value: data['available_rooms'],
                                        backgroundColor:
                                            ColorController.dirtyColor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                          icon: const Icon(
                                            Icons.cleaning_services_outlined,
                                            color: Colors.white,
                                          ),
                                          title: "Clean",
                                          value: data['clean']['count'],
                                          backgroundColor:
                                              ColorController.clean)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                        icon: const Icon(
                                          Icons.file_download_done,
                                          color: Colors.white,
                                        ),
                                        title: "Available",
                                        value: data['cleaning']['count'],
                                        backgroundColor:
                                            ColorController.availableColor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                        icon: const Icon(
                                          iconController.occupiedIcon,
                                          color: Colors.white,
                                        ),
                                        title: "Occupied",
                                        value: data['occupied'],
                                        backgroundColor:
                                            ColorController.occupiedcolor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CardNumberWidget(
                                        icon: const Icon(
                                          iconController.blocked,
                                          color: Colors.white,
                                        ),
                                        title: "Blocked",
                                        value: data['block'],
                                        backgroundColor:
                                            ColorController.blockColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
