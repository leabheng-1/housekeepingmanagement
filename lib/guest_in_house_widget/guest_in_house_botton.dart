import 'dart:convert';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:housekeepingmanagement/widget/sub_button/sub_button_frontdesd_widget.dart';

class GuestInHouseBotton extends StatefulWidget {
  const GuestInHouseBotton({super.key});

  @override
  State<GuestInHouseBotton> createState() => _GuestInHouseBottonState();
}

class _GuestInHouseBottonState extends State<GuestInHouseBotton> {
  Map<String, dynamic>? apiResponse = {};
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
      isLoading = true;
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
    final data = apiResponse!['data'] ?? '';
    return  isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 10, top: 15),
        child: Container(
          height: 80,
          width: 1200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.checkInIcon,
                      color: Colors.white,
                    ),
                    title: "Check-In",
                    value: data['checkin_count'] ?? '',
                    backgroundColor: const Color.fromARGB(255, 100, 138, 204),
                    iconbackground: Colors.blue.shade800,
                  ),
                ),
                SizedBox(width:15,),
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.arrivalsIcon,
                      color: Colors.white,
                    ),
                    title: "Arrival",
                    value: data['count_arrival'] ?? '',
                    backgroundColor: Colors.blue.shade800,
                    iconbackground: Colors.purple.shade900,
                  ),
                ),
                  SizedBox(width:15,),
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.checkOutIcon,
                      color: Colors.white,
                    ),
                    title: "Check-Out",
                    value: data['checkout_count'] ?? '',
                    backgroundColor: Colors.orange.shade500,
                    iconbackground: Colors.orange.shade900,
                  ),
                ),
                  SizedBox(width:15,),
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.departuresIcon,
                      color: Colors.white,
                    ),
                    title: "Departure",
                    value: data['count_departure'] ?? '',
                    backgroundColor: Colors.grey.shade400,
                    iconbackground: Colors.grey.shade700,
                  ),
                ),
                  SizedBox(width:15,),
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.arrivalsIcon,
                      color: Colors.white,
                    ),
                    title: "Available",
                    value: data['available_rooms'] ?? '',
                    backgroundColor: Colors.blue.shade500,
                    iconbackground: Colors.blue.shade800,
                  ),
                ),
                  SizedBox(width:15,),
                Expanded(
                  child: SubButtonFrontdeskWidget(
                    icon: const Icon(
                      iconController.inHouseIcon,
                      color: Colors.white,
                    ),
                    title: "In House",
                    value: data['inHouse'] ?? '',
                    backgroundColor: Colors.blue.shade300,
                    iconbackground: Colors.blue.shade800,
                  ),
                ),
                  SizedBox(width:30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
