import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_widget_color.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HouseKeepingBottonWidget extends StatefulWidget {
  const HouseKeepingBottonWidget({super.key});

  @override
  State<HouseKeepingBottonWidget> createState() => _SubButtonFrontdeskState();
}

class _SubButtonFrontdeskState extends State<HouseKeepingBottonWidget> {
  Map<String, dynamic>? apiResponse;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/todayStatus'));

    if (response.statusCode == 200) {
      setState(() {
        apiResponse = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (apiResponse == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = apiResponse!['data'];
    return Row(
      children: [
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.checkInIcon,
              color: Colors.white,
            ),
            title: "Check-In",
            value: data['checkin_count'],
            backgroundColor: ColorController.checkInColor,
            iconbackground: Colors.blue.shade800,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.flight_land,
              color: Colors.white,
            ),
            title: "Arrival",
            value: data['count_arrival'],
            backgroundColor: ColorController.arrivalsColor,
            iconbackground: Colors.purple.shade900,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.checkOutIcon,
              color: Colors.white,
            ),
            title: "Check-Out",
            value: data['checkout_count'],
            backgroundColor: ColorController.checkOutColor,
            iconbackground: Colors.orange.shade900,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.flight_takeoff,
              color: Colors.white,
            ),
            title: "Departure",
            value: data['count_departure'],
            backgroundColor: ColorController.departuresColor,
            iconbackground: Colors.grey.shade700,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.file_download_done,
              color: Colors.white,
            ),
            title: "Available",
            value: data['available_rooms'],
            backgroundColor: ColorController.availableColor,
            iconbackground: Colors.blue.shade800,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.inHouseIcon,
              color: Colors.white,
            ),
            title: "Inhouse",
            value: data['inHouse'],
            backgroundColor: ColorController.inhouse,
            iconbackground: Colors.blue.shade800,
          ),
        ),
      ],
    );
  }
}
