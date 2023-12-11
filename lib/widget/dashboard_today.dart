import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesd_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';
bool loading = true;
class DashboardToday extends StatefulWidget {
  const DashboardToday({Key? key}) : super(key: key);

  @override
  _DashboardTodayState createState() => _DashboardTodayState();
}

class _DashboardTodayState extends State<DashboardToday> {
  bool loading = false;
  Map<String, dynamic>? responseData;
  Map<String, dynamic> data = {};
    void initState() {
    super.initState();
  fetchData();
  loading = false;
  }
  Future<Map<String, dynamic>> fetchData() async {
    loading = false;
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/todayStatus'));

    if (response.statusCode == 200) {
      loading = true;
      responseData = json.decode(response.body);
       setState(() {
        data = responseData!['data'] ;
      });
      
      return json.decode(response.body);
    } else {
       loading = true;
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {

    return  
          Skeletonizer(
        enabled: !loading,
        child:
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
                      title: "Total Room",
                      value: data!['totalRoom'] ?? 0,
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
                      title: "Dirty",
                            value: data['dirty']?['count'] ?? 0,
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
                      value: data?['occupied'] ?? 0,
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
                            value: data['clean']?['count'] ?? 0,
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
                      value: data!['block'] ?? 0,
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
                )
          );
      }
}
