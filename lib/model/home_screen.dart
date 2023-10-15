import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeepingmanagement/model/footer.dart';
import 'package:housekeepingmanagement/system_widget/system_icon.dart';
import 'package:housekeepingmanagement/controller/main_controller.dart';
import 'package:housekeepingmanagement/dashboard/dashboard.dart';
import 'package:housekeepingmanagement/dashboard/frontdesk.dart';
import 'package:housekeepingmanagement/dashboard/guest_in_house.dart';
import 'package:housekeepingmanagement/dashboard/house_keeping.dart';
import 'package:housekeepingmanagement/dashboard/report.dart';
import 'package:intl/intl.dart';

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
    'DashBoard',
    'Front Desk',
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
    final MainController controller = Get.put(MainController());
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[300],
        body: Row(
          children: [
            Row(
              children: [
                _buildNavigationRail(),
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Aligns children to the start and end of the row
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  controller
                                      .isExpanded(!controller.isExpanded.value);
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
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
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
                                    Text(
                                      "Admin",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Receptionist",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: list[_selectedIndex],
                  ),
                  Container(
  margin: EdgeInsets.only(left:5,right:5),
  alignment: Alignment.bottomCenter,
  padding:EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  ),
  child:footer()
  
   
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
