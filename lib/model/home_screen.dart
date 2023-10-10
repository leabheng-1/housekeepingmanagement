import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/system_widget/system_color.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/controller/main_controller.dart';
import 'package:housekeepingmanagement/dashboard/dashboard.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dashboard/guest_in_house.dart';
import 'package:housekeepingmanagement/dashboard/house_keeping.dart';
import 'package:housekeepingmanagement/dashboard/report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool showNavigationBar = false;

  late List<Widget> list = [
    Dashboard(),
    FrontDesk(),
    Housekeeping(),
    GuestInHouse(),
    Report()
  ];
  final List<String> _destinations = [
    'Dashboard',
    'Frontdesk',
    'Housekeeping',
    'Guest In-House',
    'Report'
  ];

  Widget _buildNavigationRail() {
    final MainController controller = Get.put(MainController());
    return NavigationRail(
      minWidth: 50,
      extended: controller.isExpanded.value,
      labelType: NavigationRailLabelType.none,
      selectedIndex: _selectedIndex,
      leading: const CircleAvatar(
        backgroundImage: AssetImage(
          "assets/images/logo.jpg",
        ),
      ),
      onDestinationSelected: (int index) {
        setState(
          () {
            _selectedIndex = index;
            showNavigationBar = !showNavigationBar;
          },
        );
      },
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.widgets),
          selectedIcon: Icon(Icons.widgets),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.photo_camera_front_outlined),
          selectedIcon: Icon(Icons.photo_camera_front_outlined),
          label: Text('FrontDesk'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.meeting_room_outlined),
          selectedIcon: Icon(Icons.meeting_room_outlined),
          label: Text(" Housekeeping"),
        ),
        NavigationRailDestination(
          icon: Icon(
            iconController.inHouseIcon,
          ),
          selectedIcon: Icon(Icons.local_hotel_outlined),
          label: Text(" Guest In-House"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.assessment_outlined),
          selectedIcon: Icon(Icons.assessment_outlined),
          label: Text("Report"),
        ),
      ],
      groupAlignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF1F6),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          // Handle menu button press
                        },
                      ),
                      Text(
                        _destinations[_selectedIndex],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Display the Dashboard widget directly
                  Dashboard(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              )
            ],
          )
        ],
      ),
    );
  }
}
