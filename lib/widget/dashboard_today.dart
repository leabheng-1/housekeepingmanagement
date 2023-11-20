import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesd_widget.dart';
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

          return 
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:15,top:15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    Text(
      "Today",
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  

                        Padding(
                          padding: const EdgeInsets.only(right:20,top:25),
                          child:
                            Column(
              children: [
                Row(
                  children: [
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.allRoomsIcon,
                        color: Colors.white,
                      ),
                      title: "TotalRoom",
                      value: data['totalRoom'],
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.totalroom,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.availableIcon,
                        color: Colors.white,
                      ),
                      title: "Available",
                      value: data?['available_rooms'] ?? 0,
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.availableColor,
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
                        Icons.cleaning_services_outlined,
                        color: Colors.white,
                    ),
                      title: "dirty",
                            value: data['dirty']['count'],
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.dirty,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.occupiedIcon,
                        color: Colors.white,
                      ),
                      title: "Occupied",
                      value: data?['occupied'] ?? '',
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.occupiedcolor,
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
                        Icons.cleaning_services_outlined,
                        color: Colors.white,
                      ),
                      title: "Clean",
                            value: data['clean']['count'],
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.clean,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SubButtonFrontdeskWidget(
                      icon: const Icon(
                        iconController.blockIcon,
                        color: Colors.white,
                      ),
                      title: "Block",
                      value: data!['block'] ?? '',
                      textColor: Colors.black,backgroundColor: ColorController.backgroundstatustoday,
                      iconbackground: ColorController.blockColor,
                    ),
                  ],
                ),
                // Other rows and widgets...
              ],
            )
                          ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }
}
