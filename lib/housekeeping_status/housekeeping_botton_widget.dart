import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekeeping_widget_color.dart';
import 'package:housekeepingmanagement/system_widget/guest_inhouse_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skeletonizer/skeletonizer.dart';
bool loading = true;
class HouseKeepingBottonWidget extends StatefulWidget {
  const HouseKeepingBottonWidget({super.key});

  @override
  State<HouseKeepingBottonWidget> createState() => _SubButtonFrontdeskState();
}

class _SubButtonFrontdeskState extends State<HouseKeepingBottonWidget> {
  Map<String, dynamic>? apiResponse;
 Map<String, dynamic> data = {};
  @override
  void initState() {
    loading = true;
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    loading = true;
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/dashboard/todayStatus'));

    if (response.statusCode == 200) {
      loading = false; 
      apiResponse = json.decode(response.body);
      setState(() {
        loading = false;
       data = apiResponse?['data'];
    
      });
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
  
    
    return Skeletonizer(
        enabled: loading,
        child: Row(
      children: [
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.checkInIcon,
              color: Colors.white,
            ),
            title: "Check-In",
            value: data['checkin_count'] ?? 0,
            backgroundColor: ColorController.checkInColor,
            iconbackground: Color(0x66000000),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.flight_land,
              color: Colors.white,
            ),
            title: "Arrival",
            value: data['count_arrival'] ?? 0,
            backgroundColor: ColorController.arrivalsColor,
            iconbackground: Color(0x66000000),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.checkOutIcon,
              color: Colors.white,
            ),
            title: "Check-Out",
            value: data['checkout_count'] ?? 0,
            backgroundColor: ColorController.checkOutColor,
            iconbackground: Color(0x66000000),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.flight_takeoff,
              color: Colors.white,
            ),
            title: "Departure",
            value: data['count_departure'] ?? 0,
            backgroundColor: ColorController.departuresColor,
            iconbackground: Color(0x66000000),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              Icons.file_download_done,
              color: Colors.white,
            ),
            title: "Available",
            value: data['available_rooms'] ?? 0,
            backgroundColor: ColorController.availableColor,
            iconbackground: Color(0x66000000),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: HouseKeepingColorWidget(
            icon: const Icon(
              iconController.inHouseIcon,
              color: Colors.white,
            ),
            title: "Inhouse",
            value: data['inHouse'] ?? 0,
            backgroundColor: ColorController.inhouse,
            iconbackground: Color(0x66000000),
          ),
        ),
      ],
        )    );
  }
}
