import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/controller/main_controller.dart';
import 'package:housekeepingmanagement/dashboard/dashboard.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dashboard/guest_in_house.dart';
import 'package:housekeepingmanagement/dashboard/house_keeping.dart';
import 'package:housekeepingmanagement/dashboard/report.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int _selectedIndex = 0;
  bool showNavigationBar = false;

  late List<Widget> list = [
    Dashboard(),
    bookingLayout(),
    Housekeeping(),
    GuestInHouse(),
    Report()
  ];

  final List<String> _destinations = [
    'DashBoard',
    'Fron Desk',
    'Housekeeping',
    'Guest In House',
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
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: Text('Front Desk'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.email_outlined),
          selectedIcon: Icon(Icons.email),
          label: Text(" Housekeeping"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.email_outlined),
          selectedIcon: Icon(Icons.email),
          label: Text(" Guest In House"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.email_outlined),
          selectedIcon: Icon(Icons.email),
          label: Text("Report"),
        ),
      ],
      groupAlignment: 0.0,
    );
  }

  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                controller.isExpanded(!controller.isExpanded.value);
              },
            ),
            Text(
              _destinations[_selectedIndex],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 35),
            // SizedBox(
            //   width: 1000,
            //   height: 40,
            //   child: TextField(
            //     decoration: InputDecoration(
            //       prefixIcon: const Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: Colors.grey),
            //       ),
            //       hintText: 'Search',
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 70,
            ),
            Row(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 40,
                  color: Colors.grey[600],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[500],
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Admin",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      "Recectionist",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
