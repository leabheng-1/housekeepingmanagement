import 'package:flutter/material.dart';
import 'package:housekeepingmanagement/housekeeping_status/housekepping_widget.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HouseKeepingDataGuest extends StatefulWidget {
  const HouseKeepingDataGuest({super.key});

  @override
  State<HouseKeepingDataGuest> createState() => _HouseKeepingDataGuestState();
}

class _HouseKeepingDataGuestState extends State<HouseKeepingDataGuest> {
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
    print(data);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: HouseKeepingWidget(
            icon: const Icon(
              iconController.allRoomsIcon,
              color: ColorController.allRoomsColor,
              size: 40,
            ),
            title: "Total Room",
            value: data['totalRoom'],
            backgroundColor: ColorController.bottonbackcolor,
            iconbackground: ColorController.iconbackgroundcolor,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingWidget(
            icon: const Icon(
              iconController.clean,
              color: Color(0xFFFFF190),
              size: 40,
            ),
            title: "Cleaning",
            value: data['cleaning']['count'],
            backgroundColor: ColorController.bottonbackcolor,
            iconbackground: const Color(0xFFFFFADC),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingWidget(
            icon: const Icon(
              iconController.clean,
              color: Color(0xFF4E4E32),
              size: 40,
            ),
            title: "Dirty",
            value: data['dirty']['count'],
            backgroundColor: ColorController.bottonbackcolor,
            iconbackground: const Color(0xFFE1E1D6),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: HouseKeepingWidget(
            icon: const Icon(
              iconController.clean,
              color: Color(0xFF349A36),
              size: 40,
            ),
            title: "Cleaned",
            value: data['clean']['count'],
            backgroundColor: ColorController.bottonbackcolor,
            iconbackground: const Color(0xFFD8F1D8),
          ),
        ),
      ],
    );
  }
}
